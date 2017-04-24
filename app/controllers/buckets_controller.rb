class BucketsController < ApplicationController
    before_action :set_bucket, only: [:show, :update, :destroy]
    
    # GET /users/user_id/buckets
    def index
        @buckets = Bucket.all
        json_response(@buckets)
    end

    #  POST /users/user_id/buckets
    def create
        @bucket = Bucket.create!(bucket_params)
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
        params.permit(:user_id, :name)
    end

    def set_bucket
        @bucket = Bucket.find(params[:id])
    end
end
