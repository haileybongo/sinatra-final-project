class CreatePlants < ActiveRecord::Migration
  def change
    create_table :plants do |t|
      t.integer :user_id
      t.string :name
      t.string :notes
      t.string :water_id
      t.string :light
      t.timestamps null: false
    end
  end
end
