require_dependency 'boss_lady/application_controller'

module BossLady
  class FactoriesController < ApplicationController
    def new
      @form ||= FactoriesForm.build params
    end

    def index
      @factories = Factory.all
      @form ||= FactoriesForm.build params

      respond_to do |format|
        format.html
        format.json { render json: @factories }
      end
    end

    def create
      parsed_params = request.format.json? ? JSON.parse(request.raw_post).with_indifferent_access : params
      @form = params[:button] == 'build' ? FactoriesForm.build(parsed_params) : FactoriesForm.create(parsed_params)

      unless @form.valid?
        @factories = Factory.all
        return render :index
      end

      return render :new if params[:button] == 'build'
      respond_to do |format|
        format.html
        format.json { render json: @form }
      end
    end
  end
end
