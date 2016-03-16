require 'spec_helper'

describe SoftDeletablePetit::SoftDeletable do
  let(:soft_deletable_class) { Hoge }

  describe 'class methods' do
    subject{ soft_deletable_class }

    before do
      soft_deletable_class.create!
      soft_deletable_class.create!
      soft_deletable_class.create! deleted_at: Time.now
    end

    its(:soft_delete_column){ is_expected.to eq :deleted_at }

    describe '.deleted' do
      subject{ soft_deletable_class.deleted }

      its(:count){ is_expected.to eq 1 }
    end

    describe '.living' do
      subject{ soft_deletable_class.living }

      its(:count){ is_expected.to eq 2 }
    end
  end

  describe 'instance_methods' do
    let(:soft_deletable_model) { soft_deletable_class.create! }
    subject{ soft_deletable_model }

    its(:soft_delete_column){ is_expected.to eq :deleted_at }

    describe '#destroy_softly' do
      subject{ soft_deletable_model.destroy_softly }

      before do
        soft_deletable_model
      end

      it{ is_expected.to be true }

      it '.living.count change from 1 to 0' do
        expect{
          subject
        }.to change{ soft_deletable_class.living.count }.from(1).to(0)
      end

      it '.deleted.count change from 0 to 1' do
        expect{
          subject
        }.to change{ soft_deletable_class.deleted.count }.from(0).to(1)
      end

      context 'when #destroy_softly! raise error' do
        before do
          allow(soft_deletable_model).to receive(:destroy_softly!){ raise }
        end

        it{ is_expected.to be false }
      end
    end

    describe '#restore' do
      subject{ soft_deletable_model.restore }

      before do
        soft_deletable_model.destroy_softly!
      end

      it{ is_expected.to be true }

      it '.living.count change from 0 to 1' do
        expect{
          subject
        }.to change{ soft_deletable_class.living.count }.from(0).to(1)
      end

      it '.deleted.count change from 1 to 0' do
        expect{
          subject
        }.to change{ soft_deletable_class.deleted.count }.from(1).to(0)
      end

      context 'when #restore! raise error' do
        before do
          allow(soft_deletable_model).to receive(:restore!){ raise }
        end

        it{ is_expected.to be false }
      end
    end
  end
end
