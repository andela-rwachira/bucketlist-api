module V1
    class BucketsController < ApplicationController
        before_action :set_bucket, only: [:show, :update, :destroy]
        
        # GET /users/user_id/buckets
        def index
            # get paginated current user todos
            @buckets = current_user.buckets.paginate(page: params[:page], per_page: 20)
            json_response(@buckets)
        end

        #  POST /users/user_id/buckets
        def create
            @bucket = current_user.buckets.create!(bucket_params)
            json_response(@bucket, :created)
        end

        #  GET /users/user_id/buckets/id
        def show
            json_response(@bucket)
        end

        #  PUT /users/user_id/buckets/id
        def update
            @bucket = @bucket.update(bucket_params)
            head :no_content
        end

        #  DELETE /users/user_id/buckets/id
        def destroy
            @bucket.destroy
            head :no_content
        end

        private

        def bucket_params
            params.permit(:name)
        end

        def set_bucket
            @bucket = current_user.buckets.find(params[:id])
        end
    end
end
