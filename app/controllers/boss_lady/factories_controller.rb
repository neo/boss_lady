require_dependency 'boss_lady/application_controller'

module BossLady
  class FactoriesController < ApplicationController
    def index
      @factories = FactoryGirl.factories
      @form ||= FactoriesForm.new params
    end

    def create
      @form = FactoriesForm.new params

      if @form.overlapping_values
        index
        render :index
      end
    end
  end
end
