require 'rails_helper'

RSpec.describe 'UsersAPI', type: :request do

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

            it 'returns status code 400' do
                expect(response).to have_http_status(400)
            end

            it 'returns password validation failure message' do
                expect(response.body).to match(/Validation failed: Password can't be blank/)
            end
        end

        context 'when the username is invalid' do
            before { post '/users', params: invalid_username }

            it 'returns status code 400' do
                expect(response).to have_http_status(400)
            end

            it 'returns username validation failure message' do
                expect(response).to match(/Validation failed: Username can't be blank/)
            end
        end
    end
end