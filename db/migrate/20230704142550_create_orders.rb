class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :name_kana
      t.string :company
      t.string :postal_code, null: false
      t.string :prefecture_code, null: false
      t.string :city, null: false
      t.string :street_and_others, null: false
      t.string :tel, null: false
      t.integer :commission, null: false
      t.integer :postage, null: false
      t.integer :billing_amount, null: false
      t.integer :status, null: false, default: 1
      t.integer :payment_method, null: false
      t.string :card_id
      t.string :delivery_date, null: false
      t.string :delivery_time, null: false
      t.string :order_number, unique: true, default: '000000'
      t.timestamps
    end
  end
end
