class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_many :items
  has_many :item_transactions
  has_many :comments, dependent: :destroy
  has_many :sns_credentials
  has_many :favorites, dependent: :destroy
  has_many :favorite_items, through: :favorites, source: :item
  
  validates :nickname, presence: true
  validates :email, format: { with: /[@]/, message: "に@が入力されていません"}
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z{6,}/i, message: "は半角、英数字を混ぜて入力してください"}
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "は全角（漢字・ひらがな・カタカナ）で入力してください"}
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "は全角（漢字・ひらがな・カタカナ）で入力してください"}
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力してください"}
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力してください"}
  validates :birth_date, presence: true

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
      email: auth.info.email
    )
  
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end