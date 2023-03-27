class AddAddressUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :prefecture_code, :string, null: false
    add_column :users, :city, :string, null: false
    add_column :users, :street_and_others, :string, null: false
  end
end
