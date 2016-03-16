require 'active_support/configurable'
require 'active_support/core_ext/hash/slice'

module SoftDeletablePetit
  def self.configure(&block)
    yield config
  end

  def self.config
    @config ||= Configuration.new
  end

  class Configuration
    include ActiveSupport::Configurable

    config_accessor :column                     do :deleted_at end
    config_accessor :soft_delete_method_name    do :destroy_softly end
    config_accessor :restore_method_name        do :restore end
    config_accessor :soft_deleted_scope         do :deleted end
    config_accessor :without_soft_deleted_scope do :living end

    def config
      self.class.config
    end

    def merge(options)
      config.merge(options.slice(*config.keys))
    end
  end
end
