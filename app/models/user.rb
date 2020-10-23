class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :item_transactions
  
  validates :nickname, presence: true
  validates :email, format: { with: /[@]/, message: "@が入力されていません。"}
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z{6,}/i, message: "は半角、英数字を混ぜて入力してください。"}
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "は全角（漢字・ひらがな・カタカナ）で入力してください。"}
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "は全角（漢字・ひらがな・カタカナ）で入力してください。"}
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力してください。"}
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力してください。"}
  validates :birth_date, presence: true

end