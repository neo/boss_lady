require_relative '../../spec/spec_helper'

module BossLady
  RSpec.describe FactoriesForm do
    let(:params) { ActiveSupport::HashWithIndifferentAccess.new({'factories' => {factory => traits}}) }
    let(:factory) { 'computer' }
    let(:traits) { [] }
    subject { FactoriesForm.new params }

    context 'empty params' do
      let(:params) { {} }

      it 'does not do anything when no params are set' do
        expect { subject }.to_not raise_error
      end
    end

    context 'valid params' do
      context 'factory with no traits' do
        context 'traits array got an empty string' do
          let(:traits) { [''] }
          it 'removes any empty strings from traits array' do
            # Because of the way the form is generated an empty string will
            # always be part of the traits array. So just ensure it's removed before it causes trouble.

            expect(subject).to be_valid
          end
        end

        it 'creates an instance' do
          expect(subject).to be_valid
        end

        it 'has the instance available in created_factories' do
          expect(subject.created_factories[factory][:instances].size).to eq 1
        end
      end

      context 'factory with traits' do
        let(:traits) { %i(without_ssd) }

        it 'creates an instance' do
          expect(subject).to be_valid
        end

        it 'has the instance available in created_factories' do
          expect(subject.created_factories['computer'][:instances].size).to eq 1
        end

        context 'where traits array consists of strings instead of symbols' do
          let(:traits) { %w(without_ssd) }

          it 'converts the trait names to symbols' do
            expect(subject.created_factories['computer'][:instances].size).to eq 1
          end
        end
      end
    end

    context 'invalid params' do
      context 'invalid factory' do
        let(:factory) { 'invalid_factory' }

        it 'lists all the unknown factories in errors' do
          expect(subject).to_not be_valid
          expect(subject.errors[:factories]).to eq [factory]
        end
      end

      context 'invalid traits' do
        let(:traits) { %w(invalid_trait) }

        it 'lists invalid traits in errors' do
          expect(subject).to_not be_valid
          expect(subject.errors[:traits]).to eq traits.map(&:to_sym)
        end
      end

      context 'overlapping values from traits' do
        let(:traits) { %w(ram_size_16gb ram_size_32gb) }

        it 'lists all overlapping values in errors' do
          expect(subject).to_not be_valid
          expect(subject.errors[:overlapping_attributes]).to eq [:computer]
          expect(subject.created_factories['computer'][:overlapping_attributes].keys).to eq [:ram_size]
        end
      end
    end
  end
end
