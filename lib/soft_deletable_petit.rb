require "soft_deletable_petit/version"
require "soft_deletable_petit/soft_deletable"
require 'active_record'

ActiveRecord::Base.send :extend, SoftDeletablePetit::SoftDeletable
