require "soft_deletable_petit/config"

module SoftDeletablePetit
  class Builder
    attr_reader :klass, :options

    def self.build(klass, options = {})
      new(klass, options).build
    end

    def initialize(klass, options = {})
      @klass = klass
      @options = options
    end

    def build
      define_column_name_accessor(options.column)

      define_instance_methods(options.soft_delete_method_name, options.restore_method_name)
      define_scopes(options.soft_deleted_scope, options.without_soft_deleted_scope)
    end

    private

    def define_column_name_accessor(col)
      klass.class_eval do
        define_singleton_method(:soft_delete_column){ col }
        define_method(:soft_delete_column){ col }
      end
    end

    def define_instance_methods(soft_delete_method_name, restore_method_name)
      klass.class_eval do
        define_model_callbacks soft_delete_method_name
        define_model_callbacks restore_method_name

        define_method "#{soft_delete_method_name}!" do
          run_callbacks(soft_delete_method_name) { touch soft_delete_column; self }
        end
        define_method soft_delete_method_name do
          !! send("#{soft_delete_method_name}!") rescue false
        end

        define_method "#{restore_method_name}!" do
          run_callbacks(restore_method_name) { update_column soft_delete_column, nil; self  }
        end
        define_method restore_method_name do
          !! send("#{restore_method_name}!") rescue false
        end
      end
    end

    def define_scopes(soft_deleted_scope, without_soft_deleted_scope)
      klass.class_eval do
        scope soft_deleted_scope, ->{ where.not(soft_delete_column => nil) }
        scope without_soft_deleted_scope, ->{ where(soft_delete_column => nil) }

        define_method "#{soft_deleted_scope}?" do
          send("#{soft_delete_column}?")
        end

        define_method "#{without_soft_deleted_scope}?" do
          !send("#{soft_delete_column}?")
        end
      end
    end
  end
end
