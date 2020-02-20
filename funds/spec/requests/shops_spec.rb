require 'rails_helper'

RSpec.describe 'Shops API', type: :request do
  # initialize test data 
  let!(:shops) { create_list(:shop, 10) }
  let(:shop_id) { shops.first.id }

  # Test suite for GET /todos
  describe 'GET /shops' do
    # make HTTP get request before each example
    before { get '/shops' }

    it 'returns shops' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /shops/:id
  describe 'GET /shops/:id' do
    before { get "/shops/#{shop_id}" }

    context 'when the record exists' do
      it 'returns the shop' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(shop_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:shop_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Shop/)
      end
    end
  end

  # Test suite for POST /shops
  describe 'POST /shops' do
    # valid payload
    let(:valid_attributes) { { title: 'Learn Elm', location: 'Vancouver' } }

    context 'when the request is valid' do
      before { post '/shops', params: valid_attributes }

      it 'creates a shop' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/shops', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Location can't be blank/)
      end
    end
  end

  # Test suite for PUT /shops/:id
  describe 'PUT /shops/:id' do
    let(:valid_attributes) { { title: 'Fake shop' } }

    context 'when the record exists' do
      before { put "/shops/#{shop_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /shops/:id
  describe 'DELETE /shops/:id' do
    before { delete "/shops/#{shop_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end