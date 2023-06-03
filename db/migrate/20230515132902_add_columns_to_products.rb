class AddColumnsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :stock, :integer, null: false, default: 0
    add_column :products, :color, :string, null: false
  end
end
