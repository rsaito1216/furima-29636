require 'rails_helper'

RSpec.describe ItemTransactionOrder, type: :model do
  before do
    @item_transaction_order = FactoryBot.build(:item_transaction_order)
  end
  describe '商品購入' do
    context '商品購入がうまくいくとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        binding.pry
        expect(@item_transaction_order).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @item_transaction_order.building_name = nil
        expect(@item_transaction_order).to be_valid
      end
    end

    context '商品購入がうまくいかないとき' do
      it 'postal_codeが空だと保存できないこと' do
        @item_transaction_order.postal_code = nil
        @item_transaction_order.valid?
        expect(@item_transaction_order.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeがハイフンを含んだ正しい形式でないと保存できないこと' do
        @item_transaction_order.postal_code = '1234567'
        @item_transaction_order.valid?
        expect(@item_transaction_order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'prefecture_idを選択していないと保存できないこと' do
        @item_transaction_order.prefecture_id = 0
        @item_transaction_order.valid?
        expect(@item_transaction_order.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @item_transaction_order.city = nil
        @item_transaction_order.valid?
        expect(@item_transaction_order.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空だと保存できないこと' do
        @item_transaction_order.house_number = nil
        @item_transaction_order.valid?
        expect(@item_transaction_order.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @item_transaction_order.phone_number = nil
        @item_transaction_order.valid?
        expect(@item_transaction_order.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberがハイフンを含んでいると保存できないこと' do
        @item_transaction_order.phone_number = '000-0000-0000'
        @item_transaction_order.valid?
        expect(@item_transaction_order.errors.full_messages).to include("Phone number Hyphen, please do not put")
      end
      it 'phone_numberが12桁以上だと保存できないこと' do
        @item_transaction_order.phone_number = 000000000000
        @item_transaction_order.valid?
        expect(@item_transaction_order.errors.full_messages).to include("Phone number Hyphen, please do not put")
      end
      it "tokenが空では登録できないこと" do
        @item_transaction_order.token = nil
        @item_transaction_order.valid?
        expect(@item_transaction_order.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end