class ItemTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :order,dependent: :destroy
  
end
