class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :name_kana
      t.string :email, null: false
      t.string :tel
      t.string :subject, null: false
      t.text :message, null: false
      t.string :postal_code
      t.string :prefecture_code
      t.string :city
      t.string :street_and_others
     
      t.timestamps
    end
  end
end
