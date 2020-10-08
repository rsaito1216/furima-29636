class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string     :product_name,      null: false
      t.text       :description,       null: false
      t.integer    :category,          null: false
      t.integer    :condition,         null: false
      t.integer    :delivery_burden,   null: false
      t.integer    :shipping_address,  null: false
      t.integer    :shipping_days,     null: false
      t.integer    :price,             null: false
      t.references :user,              null: false,  foreign_key: true
      t.timestamps
    end
  end
end
