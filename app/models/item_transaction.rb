class ItemTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :item, dependent: :destroy
  has_one :order, dependent: :destroy
  
end
