require_dependency "boss_lady/application_controller"

module BossLady
  class FactoriesController < ApplicationController
    def index
      @factories = FactoryGirl.factories
    end

    def create
      require 'pry'
      params['factories'].each do |(factory_name, traits_array)|
        traits = traits_array.reject(&:blank?).map(&:to_sym)
        FactoryGirl.create(factory_name, *traits)
      end

      render text: 'well done'
    end
  end
end
