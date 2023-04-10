class AddNewColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username_kana, :string
    add_column :users, :postal_code, :string
    add_column :users, :address, :string
    add_column :users, :tel, :string
    add_column :users, :birthday, :date
    add_column :users, :sex, :string
    add_column :users, :job, :string
  end
end
