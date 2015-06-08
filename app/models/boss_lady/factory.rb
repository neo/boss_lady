module BossLady
  class Factory
    def self.all
      FactoryGirl.factories.collect { |factory| {name: factory.name, traits: factory.defined_traits.map(&:name)} }
    end
  end
end
