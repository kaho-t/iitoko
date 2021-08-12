class RemoveColumnsFromMessages < ActiveRecord::Migration[6.1]
  def change
    add_index :messages, [:talkroom_id, :sender_type, :created_at]
    
    remove_index :messages, [:talkroom_id, :is_user, :created_at]
  end
end
