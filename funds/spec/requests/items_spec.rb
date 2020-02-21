require 'rails_helper'

RSpec.describe 'Items API' do
  # Initialize the test data
  let(:user) { create(:user) }
  let!(:shop) { create(:shop, created_by: user.id) }
  let!(:items) { create_list(:item, 20, shop_id: shop.id) }
  let(:shop_id) { shop.id }
  let(:id) { items.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /shops/:shop_id/items
  describe 'GET /shops/:shop_id/items' do
    before { get "/shops/#{shop_id}/items", params: {}, headers: headers }

    context 'when shop exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all shop items' do
        expect(json.size).to eq(20)
      end
    end

    context 'when shop does not exist' do
      let(:shop_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Shop/)
      end
    end
  end

  # Test suite for GET /shops/:shop_id/items/:id
  describe 'GET /shops/:shop_id/items/:id' do
    before { get "/shops/#{shop_id}/items/#{id}", params: {}, headers: headers }

    context 'when shop item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when shop item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # Test suite for POST /shops/:shop_id/items
  describe 'POST /shops/:shop_id/items' do
    let(:valid_attributes) { { name: 'Cool Sword'}.to_json }

    context 'when request attributes are valid' do
      before do
        post "/shops/#{shop_id}/items", params: valid_attributes, headers: headers
      end
      

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/shops/#{shop_id}/items", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /shops/:shop_id/items/:id
  describe 'PUT /shops/:shop_id/items/:id' do
    let(:valid_attributes) { { name: 'Lightsaber' }.to_json }

    before do
      put "/shops/#{shop_id}/items/#{id}", params: valid_attributes, headers: headers
    end

    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the item' do
        updated_item = Item.find(id)
        expect(updated_item.name).to match(/Lightsaber/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # Test suite for DELETE /shops/:id
  describe 'DELETE /shops/:id' do
    before { delete "/shops/#{shop_id}/items/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end