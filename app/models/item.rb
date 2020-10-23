class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :item_transaction
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_burden
  belongs_to_active_hash :shipping_address
  belongs_to_active_hash :shipping_day

  with_options presence: true do
    validates :image
    validates :product_name
    validates :description
    validates :category_id
    validates :condition_id
    validates :delivery_burden_id
    validates :shipping_address_id
    validates :shipping_day_id
    validates :price
  end

  with_options numericality: { other_than: 0 } do
    validates :category_id
    validates :condition_id
    validates :delivery_burden_id
    validates :shipping_address_id
    validates :shipping_day_id
  end

  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "Full-width input is not possible and please be within the range"}
end
