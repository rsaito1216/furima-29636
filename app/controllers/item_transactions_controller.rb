class ItemTransactionsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :item_read, only: [:index, :create]
  before_action :sold_out_to_seller_user, only: [:index]


  def index
    @item_transaction_order = ItemTransactionOrder.new
  end

  def create
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
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: item_transaction_params[:token],
      currency:'jpy'
    )
  end

  def sold_out_to_seller_user
    if @item.item_transaction.present? || current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def item_read
    @item = Item.find(params[:item_id])
  end
end
