require 'rails_helper'

RSpec.describe 'UsersAPI', type: :request do
        # Initialize test data
        let!(:users) { create_list(:user, 10) }
        let(:user_id) { users.first.id }
        let(:headers) { valid_user_headers }

    describe 'GET /users' do
        before  { get '/users', params: {}, headers: headers }
        
        context 'when users exist' do
            it 'returns all users' do
                expect(json).not_to be_empty
                expect(json.size).to eq(10)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end
    end

    describe 'GET /users/:id' do
        before { get "/users/#{user_id}", params: {}, headers: headers }
        
        context 'when user exists' do
            it 'returns the user' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(user_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end
        
        context 'when user does not exist' do
            let(:user_id) {100}

            it 'returns a user not found error message' do
                expect(response.body).to match(/Couldn't find User/)
            end

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
        end
    end

    describe 'POST /users' do
        # Payloads
        let(:valid_attributes) { { username: 'Harry', password: '123pass' }.to_json }
        let(:invalid_password) { { username: 'Ron', password: '' }.to_json }
        let(:invalid_username) { { username: '', password: '345pass' }.to_json }

        context 'when the request is valid' do
            before { post '/users', params: valid_attributes, headers: headers }

            it 'returns a success message' do
                expect(json['message']).to match(/Account created successfully/)
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end

            it 'returns authentication token' do
                expect(json['auth_token']).not_to be_nil
            end
        end

        context 'when the password is invalid' do
            before { post '/users', params: invalid_password, headers: headers }

            it 'returns password validation failure message' do
                expect(json['message']).to match(/Validation failed: Password can't be blank/)
            end

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end
        end

        context 'when the username is invalid' do
            before { post '/users', params: invalid_username, headers: headers }

            it 'returns username validation failure message' do
                expect(json['message']).to match(/Validation failed: Username can't be blank/)
            end

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end
        end
    end

    describe 'DELETE /users/:id' do
        before { delete "/users/#{user_id}", params: {}, headers: headers }

        context 'when user exists' do
            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end

        context 'when user does not exist' do
            let(:user_id) {100}

            it 'returns a user not found error message' do
                expect(response.body).to match(/Couldn't find User/)
            end

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
        end
    end
end