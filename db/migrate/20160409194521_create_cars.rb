class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :year
      t.string :make
      t.string :model
      t.integer :mileage
      t.integer :price
      t.string :contact
      t.string :city
      t.string :state
      t.text :notes
      t.string :picture
      t.boolean :issold
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
