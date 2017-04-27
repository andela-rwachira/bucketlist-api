require 'rails_helper'

RSpec.describe 'BucketAPI', type: :request do
    # Initialize test data
    let!(:user) { create(:user) }
    let(:user_id) { user.id }
    let!(:buckets) { create_list(:bucket, 10, user_id: user.id) }
    let(:id) { buckets.first.id }
    
    describe 'GET /users/:user_id/buckets' do
        before { get "/users/#{user_id}/buckets" }

        it 'returns all buckets' do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    describe 'POST /users/:user_id/buckets' do
        let(:valid_attributes) { { name: 'Travel' } }
        let(:invalid_attributes) { { name: ''} }

        context 'when the request is valid' do
            before { post "/users/#{user_id}/buckets", params: valid_attributes }

            it 'creates the bucket' do
                expect(json['name']).to eq('Travel')
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is not valid' do
            before { post "/users/#{user_id}/buckets", params: invalid_attributes }

            it 'returns username validation error message' do
                expect(response.body).to match(/Validation failed: Name can't be blank/)
            end

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end
        end
    end

    describe 'GET /users/:user_id/buckets/:id' do
        before { get "/users/#{user_id}/buckets/#{id}" }

        context 'when bucket exists' do
            it 'returns the bucket' do
                expect(json['id']).to eq(id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when bucket does not exist' do
            let(:id) {100}

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
        end
    end

    describe 'PUT /users/:user_id/buckets/:id' do
        let(:valid_attributes) { { name: 'Updated' } }
        let(:invalid_attributes) { { name: ''} }

        context 'when request is valid' do
            before { put "/users/#{user_id}/buckets/#{id}", params: valid_attributes }

            it 'returns updated bucket' do
                expect(response.body).to be_empty
            end

            it 'returns status code 204' do
            expect(response).to have_http_status(204)
            end
        end

        context 'when when request is not valid' do
            before { put "/users/#{user_id}/buckets/#{id}", params: invalid_attributes }

            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end
    end

    describe 'DELETE /users/:user_id/buckets/:id' do
        before { delete "/users/#{user_id}/buckets/#{id}" }

        context 'when bucket exists' do
            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end
        
        context 'when bucket does not exist' do
            let(:id) {100}

            it 'returns a bucket not found message' do
                expect(response.body).to match(/Couldn't find Bucket/)
            end

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
        end
    end
end
