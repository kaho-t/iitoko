class CreateTalkrooms < ActiveRecord::Migration[6.1]
  def change
    create_table :talkrooms do |t|
      t.integer :talking_user_id
      t.integer :talking_local_id

      t.timestamps
    end
    add_index :talkrooms, :talking_user_id
    add_index :talkrooms, :talking_local_id
    add_index :talkrooms, [:talking_user_id, :talking_local_id], unique: true
  end
end
