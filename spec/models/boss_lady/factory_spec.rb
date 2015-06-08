require_relative '../../../spec/spec_helper'

module BossLady
  RSpec.describe Factory do
    describe '.all' do

      it 'lists all the factories and traits' do
        expect(Factory.all).to eq([{name: :computer,
                                    traits: [:monitor_size_27,
                                              :ram_size_16gb,
                                              :ram_size_32gb,
                                              :processor_quad_34,
                                              :processor_quad_32,
                                              :without_ssd,
                                              :storage_size_1000_5400,
                                              :storage_size_1000_7200,
                                              :graphics_card_nvidia]}])
      end
    end
  end
end
