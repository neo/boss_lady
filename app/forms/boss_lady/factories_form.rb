module BossLady
  class FactoriesForm
    attr_reader :created_factories
    attr_reader :errors

    def self.create(params)
      new params
    end

    def initialize(params)
      @created_factories = {}
      @valid = true
      @overlapping_values = false
      @errors = ActiveSupport::HashWithIndifferentAccess.new

      process params if params[:factories]
    end

    def process(params)
      params[:factories].each do |(factory_name, traits_array)|
        begin
          factory_class = FactoryGirl.factory_by_name(factory_name)
        rescue ArgumentError
          add_error(:factories, factory_name)
          next
        end

        traits_array = traits_array[:traits] if traits_array.has_key? :traits
        traits = traits_array.reject(&:blank?).map(&:to_sym)
        next if invalid_traits?(factory_class, traits)
        factory = factories_for(factory_name, traits)
        check_for_overlapping_attributes(factory_class, factory, traits)

        factory[:instances] << FactoryGirl.create(factory_name, *traits) if valid?
      end
    end

    def valid?
      @valid
    end

    private
    def add_error(error_type, value)
      @valid = false
      (@errors[error_type] ||= []) << value
    end

    def factories_for(factory_name, traits)
      @created_factories[factory_name] ||= {
          traits: traits,
          instances: [],
          used_attributes: {},
          overlapping_attributes: {},
      }
    end

    def check_for_overlapping_attributes(factory_class, factory, traits)
      factory_class.defined_traits.each do |trait|
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
            add_error :overlapping_attributes, factory_class.name
          else
            factory[:used_attributes][attr['name']] = [attr['value'], trait.name]
          end
        end
      end
    end

    def invalid_traits?(factory_class, traits)
      any_errors = false
      traits.each do |trait|
        unless factory_class.defined_traits.find { |t| t.name == trait }
          add_error :traits, trait
          any_errors = true
        end
      end

      any_errors
    end
  end
end
