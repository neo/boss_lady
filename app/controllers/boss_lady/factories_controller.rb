require_dependency 'boss_lady/application_controller'

module BossLady
  class FactoriesController < ApplicationController
    def index
      @factories = FactoryGirl.factories
    end

    def create
       @created_factories = {}
       params['factories'].each do |(factory_name, traits_array)|
         traits = traits_array.reject(&:blank?).map(&:to_sym)
         @created_factories[factory_name] ||= {
            traits: traits,
            instances: [],
        }

        @created_factories[factory_name][:instances] << FactoryGirl.create(factory_name, *traits)
      end
    end
  end
end
