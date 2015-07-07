require_relative '../../../spec/spec_helper'

module BossLady
  RSpec.describe FactoriesController, type: :controller do
    routes { BossLady::Engine.routes }
    render_views

    describe '#index' do
      it 'renders index' do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it 'gets the factories' do
        get :index
        expect(assigns(:factories)).to_not be_nil
      end

      it 'renders in json format' do
        get :index, format: 'json'
        expect(response.body).to eq(Factory.all.to_json)
      end
    end

    describe '#create' do
      let(:params) { {factories: {computer: { traits:  [] } }} }

      it 'creates the model from the specified factory' do
        expect {
          post :create, params
        }.to change { Computer.count }
        expect(response).to have_http_status(:ok)
      end

      it 'creates the model from the specified factory with traits' do
        params = {factories: {computer: {traits: ['without_ssd']}}}
        expect {
          post :create, params
        }.to change { Computer.count }
        expect(response).to have_http_status(:ok)
        expect(Computer.last.ssd).to eq(false)
      end

      it 'creates the model from a json' do
        params = { factories: {computer: {traits: ['without_ssd']}} }
        expect {
          post :create, params.to_json, format: 'json'
        }.to change { Computer.count }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include('created_factories', 'valid', 'errors', 'overlapping_values')
        expect(Computer.last.ssd).to eq(false)
      end

      it 'has all the newly created factory instances available for the view' do
        post :create, params

        created_factories = assigns(:form).created_factories
        expect(created_factories['computer'][:traits]).to be_empty
        expect(created_factories['computer'][:instances].size).to eq(1)
      end

      it 'renders index to show all the selected traits when there are overlapping values used in traits' do
        params = {factories: {computer: { traits: %w(ram_size_16gb ram_size_32gb)} }}
        post :create, params

        expect(response).to have_rendered(:index)
        expect(assigns(:form).created_factories['computer'][:overlapping_attributes]).to eq({ram_size: {
                                                                                                values: [16_192, 32_384],
                                                                                                traits: [:ram_size_16gb, :ram_size_32gb],
                                                                                            }})
      end
    end
  end
end
