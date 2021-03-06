class ItemTransactionOrder
  
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :user_id, :item_id, :token
  
  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9０-９]+[ー|-][0-9０-９]+\z/, message: "にハイフン(ー)を入力してください"}
    
    validates :city
    validates :house_number
    validates :phone_number, format: {with: /\A[0-9０-９]{,11}\z/, message: "にハイフン(ー)を入力しないでください"}
    validates :token
  end

  validates :prefecture_id, numericality: { other_than: 0, message: "を選択入力してください"}

  def save
    item_transaction = ItemTransaction.create(user_id: user_id, item_id: item_id)
    Order.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, item_transaction_id: item_transaction.id)
  end
  
end