require 'rails_helper'

RSpec.describe 'Items API', type: :request do
    # Initialize test data
    let!(:user) { create(:user) }
    let(:user_id) { user.id }
    let!(:bucket) { create(:bucket, user_id: user.id) }
    let(:bucket_id) { bucket.id}
    let!(:items) { create_list(:item, 10, bucket_id: bucket.id)}
    let(:id) { items.first.id }

    describe 'GET /users/:user_id/buckets/:bucket_id/items' do
        before { get "/users/#{user_id}/buckets/#{bucket_id}/items" }

        it 'returns all items' do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    describe 'POST /users/:user_id/buckets/:bucket_id/items' do
        let(:valid_attributes) { { name: 'Things', done: false } }
        let(:invalid_attributes) { { name: '' } }

        context 'when the request is valid' do
            before { post "/users/#{user_id}/buckets/#{bucket_id}/items", params: valid_attributes }

            it 'creates the item' do
                expect(json['name']).to eq('Things')
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do
            before { post "/users/#{user_id}/buckets/#{bucket_id}/items", params: invalid_attributes }

            it 'returns name validation error' do
                expect(response.body).to match(/Validation failed: Name can't be blank/)
            end

            it 'returns status code 500' do
                expect(response).to have_http_status(500)
            end
        end
    end

    describe 'GET /users/:user_id/buckets/:bucket_id/items/:id' do
        before { get "/users/#{user_id}/buckets/#{bucket_id}/items/#{id}" }

        context 'when item exists' do
            it 'returns the item' do
                expect(json['id']).to eq(id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when item does not exist' do
            let(:id) {100}

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
        end
    end

    describe 'PUT /users/:user_id/buckets/:bucket_id/items/:id' do
        let(:valid_attributes) { { name: 'Updated' } }
        let(:one_attribute) { { done: true } }
        let(:invalid_attributes) { { name: '' } }

        context 'when a request is valid' do
            before { put "/users/#{user_id}/buckets/#{bucket_id}/items/#{id}", params: valid_attributes }

            it 'returns updated item' do
                updated_item = Item.find(id)
                expect(updated_item.name).to match(/Updated/)
            end

            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end

        context 'when an update request has only one attribute' do
            before { put "/users/#{user_id}/buckets/#{bucket_id}/items/#{id}", params: one_attribute }

            it 'returns updated item' do
                updated_item = Item.find(id)
                expect(updated_item.done).to match(/true/)
            end

            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end

        context 'when a request is not valid' do
            before { put "/users/#{user_id}/buckets/#{bucket_id}/items/#{id}", params: invalid_attributes }

            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end

        context 'when item does not exist' do
            before { put "/users/#{user_id}/buckets/#{bucket_id}/items/#{id}", params: valid_attributes }
            let(:id) {100}

            it 'returns an item not found error message' do
                expect(response.body).to match(/Couldn't find Item/)
            end

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
        end
    end

    describe 'DELETE /users/:user_id/buckets/:bucket_id/items/:id' do
        before { delete "/users/#{user_id}/buckets/#{bucket_id}/items/#{id}" }
        
        context 'when item exists' do
            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end

        context 'when item does not exist' do
            let(:id) {100}

            it 'retuns an item not found message' do
                expect(response.body).to match(/Couldn't find Item/)
            end

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
        end
    end
end
