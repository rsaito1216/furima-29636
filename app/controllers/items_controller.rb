class ItemsController < ApplicationController
  before_action :login_check, only: [:new]
  
  def index
    @items = Item.all
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to action: :index
    else
      render action: :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :product_name, :description, :category_id, :condition_id, :delivery_burden_id, :shipping_address_id, :shipping_day_id, :price).merge(user_id: current_user.id)
  end

  def login_check
    unless user_signed_in?
      flash[:alert] = "出品するにはログインか新規登録をしてください"
      redirect_to new_user_session_path
    end
  end
end
