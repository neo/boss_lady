require_relative '../../../spec/spec_helper'

module BossLady
  RSpec.describe FactoriesController, type: :controller do

    routes { BossLady::Engine.routes }

    describe '#index' do
      it 'renders index' do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it 'gets the factories' do
        get :index
        expect(assigns(:factories)).to_not be_nil
      end
    end

    describe '#create' do
      let(:params) { {factories: {computer: ['']}} }

      it 'creates the model from the specified factory' do
        expect {
          post :create, params
        }.to change { Computer.count }
        expect(response).to have_http_status(:ok)

      end

      it 'creates the model from the specified factory with traits' do
        params = {factories: {computer: ['without_ssd']}}
        expect {
          post :create, params
        }.to change { Computer.count }
        expect(response).to have_http_status(:ok)
        expect(Computer.last.ssd).to eq(false)
      end

      it 'has all the newly created factory instances available for the view' do
        post :create, params

        created_factories = assigns(:created_factories)
        expect(created_factories['computer'][:traits]).to be_empty
        expect(created_factories['computer'][:instances].size).to eq(1)
      end
    end
  end
end
