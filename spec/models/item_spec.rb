require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品登録' do
    context '商品出品登録がうまくいくとき' do
      it "image、product_name、description、category_id、condition_id、delivery_burden_id、shipping_address_id、shipping_days_id、priceが存在すれば登録できる" do
        expect(@item).to be_valid
      end
      it "priceが半角数字であれば登録できること" do
        @item.price = 3000
        expect(@item).to be_valid
      end
    end
    context '商品出品登録がうまくいかないとき' do
      it "imageが空だと登録できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("出品画像を入力してください")
      end
      it "product_nameが空では登録できない" do
        @item.product_name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it "descriptionが空では登録できない" do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      # it "category_idが空では登録できない" do
      #   @item.category_id = ""
      #   @item.valid?
      #   expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      # end
      # it 'category_idを選択していないと登録できない' do
      #   @item.category_id = 0
      #   @item.valid?
      #   expect(@item.errors.full_messages).to include("カテゴリーを選択入力してください")
      # end
      it "condition_idが空では登録できない" do
        @item.condition_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end
      it 'condition_idを選択していないと登録できない' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選択入力してください")
      end
      it "delivery_burden_idが空では登録できない" do
        @item.delivery_burden_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end
      it 'delivery_burden_idを選択していないと登録できない' do
        @item.delivery_burden_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選択入力してください")
      end
      it "shipping_address_idが空では登録できない" do
        @item.shipping_address_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end
      it 'shipping_address_idを選択していないと登録できない' do
        @item.shipping_address_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選択入力してください")
      end
      it "shipping_day_idが空では登録できない" do
        @item.shipping_day_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end
      it 'shipping_day_idを選択していないと登録できない' do
        @item.shipping_day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選択入力してください")
      end
      it "priceが空では登録できない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください")
      end
      it 'priceが全角数字だと登録できない' do
        @item.price = "１０００"
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数字で、価格範囲内で入力してください")
      end
      it 'priceが300円未満では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数字で、価格範囲内で入力してください")
      end
      it 'priceが10,000,000円以上だと登録できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数字で、価格範囲内で入力してください")
      end
      it 'userが紐付いていないと保存できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
