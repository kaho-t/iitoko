class ChangeColumnDefaultToScores < ActiveRecord::Migration[6.1]
  def change
    change_column_null :scores, :user_id, true
    change_column_default :scores, :user_id, ""
  end
end
