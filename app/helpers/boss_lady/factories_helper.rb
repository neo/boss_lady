module BossLady
  module FactoriesHelper
    def factory_to_be_created?(factory_name)
      @form.created_factories.include? factory_name.to_s if @form.created_factories
    end

    def trait_to_be_created?(factory_name, trait)
      @form.created_factories[factory_name.to_s][:traits].include? trait if @form.created_factories && @form.created_factories[factory_name.to_s]
    end
  end
end
