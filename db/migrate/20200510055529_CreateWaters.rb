class CreateWaters < ActiveRecord::Migration[4.2]
  def change
    create_table :waters do |t|
      t.integer :plant_id
      t.string :name
      t.string :winter
      t.string :summer
      t.string :soil
      t.string :humidity
      t.timestamps null: false
    end
  end
end
