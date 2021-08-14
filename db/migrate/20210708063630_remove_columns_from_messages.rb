class RemoveColumnsFromMessages < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :messages, :talkrooms
    remove_index :messages, [:talkroom_id, :is_user, :created_at]
  end
end
