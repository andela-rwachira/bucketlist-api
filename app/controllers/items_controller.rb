class ItemsController < ApplicationController
    before_action :set_item, only: [:show, :update, :destroy]

    # GET /users/:user_id/buckets/:bucket_id/items
    def index
        @items = Item.all
        json_response(@items)
    end

    # POST /users/:user_id/buckets/:bucket_id/items
    def create
        @item = Item.create!(item_params)
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
        params.permit(:bucket_id, :name)
    end

    def set_item
        @item = Item.find(params[:id])
    end
end
