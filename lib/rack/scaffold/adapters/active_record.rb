# frozen_string_literal: true

require 'active_record'
require 'forwardable'

module Rack::Scaffold::Adapters
  class ActiveRecord < Base
    extend Forwardable

    def_delegators :@klass, :count, :all, :find, :create!, :update!, :destroy!

    class << self
      def ===(model)
        ::ActiveRecord::Base === model
      end

      def resources(model, _options = {})
        model
      end

      def timestamps?
        record_timestamps?
      end
    end

    def singular
      @klass.name.downcase
    end

    def plural
      @klass.table_name
    end

    def paginate(limit, offset)
      @klass.limit(limit).offset(offset)
    end

    def [](id)
      find(id)
    end

    def one_to_many_associations
      @klass.reflect_on_all_associations(:has_many).collect(&:name)
    end

    def update_timestamp_field
      attribute_names.include?('updated_at') ? 'updated_at' : 'updated_on'
    end
  end
end
