class Category < ApplicationRecord
  has_ancestry
  has_many :items , dependent: :destroy
end
