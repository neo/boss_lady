module BossLady
  module FactoriesHelper
    def factory_to_be_created?(factory_name)
      @created_factories.include? factory_name.to_s if @created_factories
    end

    def trait_to_be_created?(factory_name, trait)
      @created_factories[factory_name.to_s][:traits].include? trait if @created_factories && @created_factories[factory_name.to_s]
    end
  end
end
