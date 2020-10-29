class ItemsController < ApplicationController
  before_action :login_check, only: [:new]
  before_action :set_item, only: [:edit, :show, :update, :destroy]

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

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render action: :edit
    end
  end

  def destroy
    if @item.user_id == current_user.id
      @item.destroy
      redirect_to action: :index
    else
      render action: :show
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

  def set_item
    @item = Item.find(params[:id])
  end
end
