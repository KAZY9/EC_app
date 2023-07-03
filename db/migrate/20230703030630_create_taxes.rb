class CreateTaxes < ActiveRecord::Migration[7.0]
  def change
    create_table :taxes do |t|
      t.float :rate, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date
      t.timestamps
    end

    add_index :taxes, :id, unique: true
    add_index :taxes, :rate, unique: true
  end
end
