module V1
    class ItemsController < ApplicationController
        before_action :set_bucket
        before_action :set_bucket_item, only: [:show, :update, :destroy]

        # GET /users/:user_id/buckets/:bucket_id/items
        def index
            json_response(@bucket.items)
        end

        # POST /users/:user_id/buckets/:bucket_id/items
        def create
            @item = @bucket.items.create!(item_params)
            json_response(@item, :created)
        end

        # GET /users/:user_id/buckets/:bucket_id/items/:id
        def show
            json_response(@item)
        end

        # PUT /users/:user_id/buckets/:bucket_id/items/:id
        def update
            @item = @item.update(item_params)
            head :no_content
        end

        # DELETE /users/:user_id/buckets/:bucket_id/items/:id
        def destroy
            @item.destroy
            head :no_content
        end

        private

        def item_params
            params.permit(:bucket_id, :name, :done)
        end

        def set_bucket
            @bucket = Bucket.find(params[:bucket_id])
        end

        def set_bucket_item
            @item = @bucket.items.find_by!(id: params[:id]) if @bucket
        end
    end
end
