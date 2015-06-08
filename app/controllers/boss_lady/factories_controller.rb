require_dependency 'boss_lady/application_controller'

module BossLady
  class FactoriesController < ApplicationController
    def index
      @factories = Factory.all
      @form ||= FactoriesForm.new params

      respond_to do |format|
        format.html
        format.json { render json: @factories }
      end
    end

    def create
      @form = FactoriesForm.new params

      render :index unless @form.valid?
    end
  end
end
