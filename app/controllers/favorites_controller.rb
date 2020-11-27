class FavoritesController < ApplicationController
  before_action :set_item 

  def create
    @favorite = Favorite.new(user_id: current_user.id,  item_id: @item.id)
    @favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, item_id:  @item.id)
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_item
    @item = Item.find_by(id: params[:item_id])
  end
end
