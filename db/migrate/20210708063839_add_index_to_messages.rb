class AddIndexToMessages < ActiveRecord::Migration[6.1]
  def change
    add_index :messages, [:talkroom_id, :sender_type, :created_at]
  end
end
