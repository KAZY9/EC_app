class AddColumns2ToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :brand, :string, null: false
    add_column :products, :shape, :string, null: false
    add_column :products, :carrying_style, :string, null: false
    add_column :products, :style, :string, null: false
    add_column :products, :closure_method, :string, null: false
  end
end
