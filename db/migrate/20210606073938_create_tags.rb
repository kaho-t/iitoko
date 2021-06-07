class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.boolean :sea
      t.boolean :mountain
      t.boolean :river
      t.boolean :field
      t.boolean :hotspring
      t.boolean :north
      t.boolean :south
      t.boolean :easy_to_go
      t.boolean :small_city
      t.boolean :car
      t.boolean :train
      t.boolean :low_price
      t.boolean :moving_support
      t.boolean :entrepreneur_support
      t.boolean :child_care_support
      t.boolean :job_change_support
      t.boolean :park
      t.boolean :education
      t.boolean :food
      t.boolean :architecture
      t.boolean :history
      t.boolean :event
      t.boolean :tourism
      t.references :local, null: false, foreign_key: true

      t.timestamps
    end
  end
end
