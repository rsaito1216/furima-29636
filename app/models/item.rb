class Item < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_one :item_transaction
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user , dependent: :destroy
  belongs_to :category
  
  scope :with_keywords, -> name_keywords {
    if name_keywords.present?
      columns = [:product_name]
      where(name_keywords.split(/[[:blank:]]+/).reject(&:empty?).map {|keyword|
        columns.map { |a| arel_table[a].matches("%#{keyword}%") }.inject(:or)
      }.inject(:or))
    end
  }
  scope :with_description_keywords, -> description_keywords {
    if description_keywords.present?
      columns = [:description]
      where(description_keywords.split(/[[:blank:]]+/).reject(&:empty?).map {|keyword|
        columns.map { |a| arel_table[a].matches("%#{keyword}%") }.inject(:or)
      }.inject(:or))
    end
  }

  def self.search(search)
    if search != ""
      Item.where('product_name LIKE(?) or description LIKE(?)', "%#{search}%","%#{search}%")
    else
      Item.all
    end
  end

  def previous
    Item.where("id < ?", self.id).order("id DESC").first
  end

  def next
    Item.where("id > ?", self.id).order("id ASC").first
  end

  ransacker :favorites_count do
    query = '(SELECT COUNT(favorites.item_id) FROM favorites where favorites.item_id = items.id GROUP BY favorites.item_id)'
    Arel.sql(query)
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  # belongs_to_active_hash :category
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

  default_scope -> { order(created_at: :desc) }

end
