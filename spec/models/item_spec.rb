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
        @item.price = "3000"
        expect(@item).to be_valid
      end
    end
    context '商品出品登録がうまくいかないとき' do
      it "imageが空だと登録できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "product_nameが空では登録できない" do
        @item.product_name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Product name can't be blank")
      end
      it "descriptionが空では登録できない" do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it "category_idが空では登録できない" do
        @item.category_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank", "Category is not a number")
      end
      it 'category_idを選択していないと登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 0")
      end
      it "condition_idが空では登録できない" do
        @item.condition_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank", "Condition is not a number")
      end
      it 'condition_idを選択していないと登録できない' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be other than 0")
      end
      it "delivery_burden_idが空では登録できない" do
        @item.delivery_burden_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery burden can't be blank", "Delivery burden is not a number")
      end
      it 'delivery_burden_idを選択していないと登録できない' do
        @item.delivery_burden_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery burden must be other than 0")
      end
      it "shipping_address_idが空では登録できない" do
        @item.shipping_address_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping address can't be blank", "Shipping address is not a number")
      end
      it 'shipping_address_idを選択していないと登録できない' do
        @item.shipping_address_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping address must be other than 0")
      end
      it "shipping_day_idが空では登録できない" do
        @item.shipping_day_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank", "Shipping day is not a number")
      end
      it 'shipping_day_idを選択していないと登録できない' do
        @item.shipping_day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day must be other than 0")
      end
      it "priceが空では登録できない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが全角数字だと登録できない' do
        @item.price = "１０００"
        binding.pry
        
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Full-width input is not possible and please be within the range")
      end
      it 'priceが300円未満では登録できない' do
        @item.price = "299"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Full-width input is not possible and please be within the range")
      end
      it 'priceが10,000,000円以上だと登録できない' do
        @item.price = "10000000"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Full-width input is not possible and please be within the range")
      end
      it 'userが紐付いていないと保存できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
