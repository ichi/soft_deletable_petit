require 'spec_helper'

describe SoftDeletablePetit::SoftDeletable do
  let(:soft_deletable_class) do
    options = soft_deletable_options
    Class.new(ActiveRecord::Base) do
      soft_deletable **options
    end
  end
  let(:soft_deletable_model){ soft_deletable_class.new }
  let(:soft_deletable_options){ {} }

  subject{ soft_deletable_class.instance_variable_get :'@_soft_deletable_options' }

  context 'by defult' do
    it{ is_expected.to have_attributes({
      column:                     :deleted_at,
      soft_delete_method_name:    :destroy_softly,
      restore_method_name:        :restore,
      soft_deleted_scope:         :deleted,
      without_soft_deleted_scope: :living,
    }) }
  end

  context 'with options' do
    let(:soft_deletable_options){ {
      column:                     :m_deleted_at,
      soft_delete_method_name:    :m_destroy_softly,
      restore_method_name:        :m_restore,
      soft_deleted_scope:         :m_deleted,
      without_soft_deleted_scope: :m_living,
    } }

    it{ is_expected.to have_attributes({
      column:                     :m_deleted_at,
      soft_delete_method_name:    :m_destroy_softly,
      restore_method_name:        :m_restore,
      soft_deleted_scope:         :m_deleted,
      without_soft_deleted_scope: :m_living,
    }) }
  end

  context 'configure on module' do
    around(:each) do |ex|
      begin
        old = SoftDeletablePetit.config.config
        SoftDeletablePetit.configure do |c|
          c.column                      = :c_deleted_at
          c.soft_delete_method_name     = :c_destroy_softly
          c.restore_method_name         = :c_restore
          c.soft_deleted_scope          = :c_deleted
          c.without_soft_deleted_scope  = :c_living
        end

        ex.run
      ensure
        old.each{|k, v| SoftDeletablePetit.config.send "#{k}=", v }
      end
    end

    it{ is_expected.to have_attributes({
      column:                     :c_deleted_at,
      soft_delete_method_name:    :c_destroy_softly,
      restore_method_name:        :c_restore,
      soft_deleted_scope:         :c_deleted,
      without_soft_deleted_scope: :c_living,
    }) }

    context 'and with options' do
      let(:soft_deletable_options){ {
        column:                     :m_deleted_at,
        soft_delete_method_name:    :m_destroy_softly,
        soft_deleted_scope:         :m_deleted,
      } }

      it{ is_expected.to have_attributes({
        column:                     :m_deleted_at,
        soft_delete_method_name:    :m_destroy_softly,
        restore_method_name:        :c_restore,
        soft_deleted_scope:         :m_deleted,
        without_soft_deleted_scope: :c_living,
      }) }
    end
  end
end
