module BossLady
  class FactoriesForm
    attr_reader :created_factories
    attr_reader :overlapping_values

    def initialize(params)
      @created_factories = {}
      @overlapping_values = false

      process(params) if params.include? 'factories'
    end

    def process(params)
      params['factories'].each do |(factory_name, traits_array)|
        traits = traits_array.reject(&:blank?).map(&:to_sym)
        @created_factories[factory_name] ||= {
            traits: traits,
            instances: [],
            used_attributes: {},
            overlapping_attributes: {},
        }
        factory = @created_factories[factory_name]
        FactoryGirl.factories[factory_name].defined_traits.each do |trait|
          next unless traits.include? trait.name

          trait.attributes.map do |a|
            attr = a.instance_values

            if factory[:used_attributes].include? attr['name']
              overlapping = factory[:overlapping_attributes][attr['name']] ||= {
                  values: [factory[:used_attributes][attr['name']][0]],
                  traits: [factory[:used_attributes][attr['name']][1]],
              }
              overlapping[:values] << attr['value']
              overlapping[:traits] << trait.name
              @overlapping_values = true
            else
              factory[:used_attributes][attr['name']] = [attr['value'], trait.name]
            end
          end
        end

        @created_factories[factory_name][:instances] << FactoryGirl.create(factory_name, *traits) unless @overlapping_values
      end
    end
  end
end
