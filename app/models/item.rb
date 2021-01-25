class Item < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_one :item_transaction
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user , dependent: :destroy

  
  
  def self.search(search)
    if search != ""
      Item.where('product_name LIKE(?) or description LIKE(?)', "%#{search}%","%#{search}%")
    else
      Item.all
    end
  end
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_burden
  belongs_to_active_hash :shipping_address
  belongs_to_active_hash :shipping_day

  with_options presence: true do
    validates :images
    validates :product_name
    validates :description
    validates :category_id
    validates :condition_id
    validates :delivery_burden_id
    validates :shipping_address_id
    validates :shipping_day_id
    validates :price
  end

  with_options numericality: { other_than: 0 , message: "を選択入力してください"} do
    validates :category_id
    validates :condition_id
    validates :delivery_burden_id
    validates :shipping_address_id
    validates :shipping_day_id
  end

  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "は半角数字で、価格範囲内で入力してください"}
end
