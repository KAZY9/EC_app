class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :name, null: false
      t.string :name_kana
      t.string :company
      t.string :postal_code, null: false
      t.string :prefecture_code, null: false
      t.string :city, null: false
      t.string :street_and_others, null: false
      t.string :tel, null: false

      t.timestamps
    end
  end
end
