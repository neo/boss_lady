require '../spec_helper'

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
      it 'creates the model from the specified factory' do
        params = { factories: { computer: [""] }}
        expect {
          post :create, params
        }.to change { Computer.count }
        expect(response).to have_http_status(:ok)

      end

      it 'creates the model from the specified factory with traits' do
        params = { factories: { computer: ['without_ssd']} }
        expect {
          post :create, params
        }.to change { Computer.count }
        expect(response).to have_http_status(:ok)
        expect(Computer.last.ssd).to eq(false)
      end
    end
  end
end
