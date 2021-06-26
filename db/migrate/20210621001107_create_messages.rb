class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :talkroom, null: false, foreign_key: true, index: false
      t.integer :sent_from
      t.boolean :is_user
      t.text :content
      t.string :category

      t.timestamps
    end
    add_index :messages, [:talkroom_id, :is_user, :created_at]
  end
end
