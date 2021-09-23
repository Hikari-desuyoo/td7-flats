class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.string :title
      t.string :description
      t.integer :rooms
      t.integer :bathrooms
      t.boolean :allow_pets
      t.boolean :parking_available
      t.decimal :daily_price

      t.timestamps
    end
  end
end
