class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :text, presence: true

  default_scope -> { order(created_at: :desc) }

end
