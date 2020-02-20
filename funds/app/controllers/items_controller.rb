class ItemsController < ApplicationController
  before_action :set_shop
  before_action :set_shop_item, only:[:show, :update, :destroy]

  # GET /shops/:shop_id/items
  def index
    json_response(@shop.items)
  end

  # GET /shops/:shop_id/items/:id
  def show
    json_response(@item)
  end

  # POST /shops/:shop_id/items
  def create
    @shop.items.create!(item_params)
    json_response(@item, :created)
  end

  # PUT /shops/:shop_id/items/:id
  def update
    @item.update(item_params)
    head :no_content
  end

  # DELETE /shops/:shop_id/items/:id
  def destroy
    @item.destroy
    head :no_content
  end

  private

  def item_params
    params.permit(:name)
  end

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def set_shop_item
    @item = @shop.items.find_by!(id: params[:id]) if @shop
  end

end
