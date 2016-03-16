require "soft_deletable_petit/config"
require "soft_deletable_petit/builder"

module SoftDeletablePetit
  module SoftDeletable
    def soft_deletable(options = {})
      @_soft_deletable_options = SoftDeletablePetit.config.merge(options)
      SoftDeletablePetit::Builder.build(self, @_soft_deletable_options)
    end
  end
end
