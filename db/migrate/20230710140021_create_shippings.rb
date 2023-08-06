class CreateShippings < ActiveRecord::Migration[7.0]
  def change
    create_table :shippings do |t|
      t.integer :address_id, :null => false
      t.references :user, null: false, foreign_key: true
    
      t.timestamps
    end
  end
end
