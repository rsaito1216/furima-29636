class Order < ApplicationRecord
  belongs_to :item_transaction

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

end
