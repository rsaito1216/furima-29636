FactoryBot.define do
  factory :item do
    product_name { 'aA1１あ阿ア' }
    description {Faker::Lorem.sentence}
    category_id { 1 }
    condition_id { 1 }
    delivery_burden_id { 1 }
    shipping_address_id { 1 }
    shipping_day_id { 1 }
    price { '2000' }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
