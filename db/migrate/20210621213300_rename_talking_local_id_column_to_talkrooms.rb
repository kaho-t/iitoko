class RenameTalkingLocalIdColumnToTalkrooms < ActiveRecord::Migration[6.1]
  def change
    add_reference :talkrooms, :user, foreign_key: true
    add_reference :talkrooms, :local, foreign_key: true
    add_index :talkrooms, [:user_id, :local_id], unique: true

    remove_columns :talkrooms, :talking_user_id, :talking_local_id
  end
end