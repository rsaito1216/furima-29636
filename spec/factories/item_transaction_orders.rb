FactoryBot.define do
  factory :item_transaction_order do
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { '東京都' }
    house_number { '1-1' }
    building_name { '東京ハイツ' }
    phone_number { '00000000000' }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
