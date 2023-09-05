class AddReleaseFlagToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :release_flag, :integer, null: false, default: 0
  end
end
