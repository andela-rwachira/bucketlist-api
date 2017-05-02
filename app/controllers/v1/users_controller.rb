module V1
    class UsersController < ApplicationController
        skip_before_action :authorize_request, only: :create
        before_action :set_user, only: [:show, :destroy]
        
        # GET /users
        def index
            @users = User.all
            json_response(@users)
        end

        # POST /users
        def create
            user = User.create!(user_params)
            auth_token = AuthenticateUser.new(user.username, user.password).call
            response = { message: Message.account_created, auth_token: auth_token, user_id: user.id }
            json_response(response, :created)
        end

        # GET /users/:id
        def show
            json_response(@user)
        end

        # DELETE /users/:id
        def destroy
            @user.destroy
            head :no_content
        end

        private

        def user_params
            params.permit(:username, :password)
        end

        def set_user
            @user = User.find(params[:id])
        end
    end
end
