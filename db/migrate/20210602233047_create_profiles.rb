class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.text :introduction
      t.integer :population
      t.integer :temperature
      t.integer :moved_in
      t.integer :waiting_children
      t.integer :land_price
      t.integer :income
      t.integer :crime_rate
      t.references :local, null: false, foreign_key: true

      t.timestamps
    end
  end
end
