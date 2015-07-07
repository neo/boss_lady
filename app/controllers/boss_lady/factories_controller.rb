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
      @form = FactoriesForm.create(request.format.json? ? JSON.parse(request.raw_post).with_indifferent_access : params)

      unless @form.valid?
        @factories = Factory.all
        return render :index
      end

      respond_to do |format|
        format.html
        format.json { render json: @form }
      end
    end
  end
end
