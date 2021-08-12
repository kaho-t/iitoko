class RenameTalkingLocalIdColumnToTalkrooms < ActiveRecord::Migration[6.1]
  def change
    add_index :talkrooms, [:user, :local], unique: true

    remove_columns :talkrooms, :talking_user_id, :talking_local_id
    remove_index :talkrooms, [:talking_user_id, :talking_local_id]
  end
end
