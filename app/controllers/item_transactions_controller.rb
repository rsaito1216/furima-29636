class ItemTransactionsController < ApplicationController
  before_action :move_login, only: [:index]
  before_action :seller_user, only: [:index]
  before_action :sold_out, only: [:index]

  def index
    @item = Item.find(params[:item_id])
    @item_transaction_order = ItemTransactionOrder.new
  end

  def create
    @item = Item.find(params[:item_id])
    @item_transaction_order = ItemTransactionOrder.new(item_transaction_params)
    if @item_transaction_order.valid?
      pay_item
      @item_transaction_order.save
      redirect_to items_path
    else
      render action: :index
    end
  end


  private

  def item_transaction_params
    params.require(:item_transaction_order).permit(:item_id, :token, :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id,item_id: params[:item_id],token: params[:token])
  end

  def pay_item
    @item = Item.find(params[:item_id])
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: item_transaction_params[:token],
      currency:'jpy'
    )
  end


  def move_login
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def seller_user
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def sold_out
    @item = Item.find(params[:item_id])
    if @item.item_transaction.present?
      redirect_to root_path
    end
  end
end
