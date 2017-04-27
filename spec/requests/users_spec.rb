require 'rails_helper'

RSpec.describe 'UsersAPI', type: :request do
        # Initialize test data
        let!(:users) { create_list(:user, 10) }
        let(:user_id) { users.first.id }

    describe 'GET /users' do
        before  { get '/users' }
        
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
        before { get "/users/#{user_id}" }
        
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
        let(:valid_attributes) { { username: 'Harry Potter', password: '123pass' } }
        let(:invalid_password) { { username: 'Ron Weasley', password: '' } }
        let(:invalid_username) { { username: '', password: '345pass' } }

        context 'when the request is valid' do
            before { post '/users', params: valid_attributes }

            it 'creates a user' do
                expect(json['username']).to eq('Harry Potter')
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the password is invalid' do
            before { post '/users', params: invalid_password }

            it 'returns password validation failure message' do
                expect(response.body).to match(/Validation failed: Password can't be blank/)
            end

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end
        end
        # TODO: fix strange error caused by line 84:
        context 'when the username is invalid' do
            before { post '/users', params: invalid_username }

            # it 'returns username validation failure message' do
            #     expect(response).to match(/Validation failed: Username can't be blank/)
            # end

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end
        end
    end

    describe 'DELETE /users/:id' do
        before { delete "/users/#{user_id}" }

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