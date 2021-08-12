class RenameTalkingLocalIdColumnToTalkrooms < ActiveRecord::Migration[6.1]
  def change
    remove_columns :talkrooms, :talking_user_id, :talking_local_id
  end
end
