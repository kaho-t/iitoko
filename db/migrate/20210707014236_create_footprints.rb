class CreateFootprints < ActiveRecord::Migration[6.1]
  def change
    create_table :footprints do |t|
      t.integer :visitoruser_id, null: true
      t.integer :visiteduser_id, null: true
      t.integer :visitorlocal_id, null:true
      t.integer :visitedlocal_id, null: true

      t.timestamps
    end
  end
end
