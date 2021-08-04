class ChangeColumnNullToUserProfile < ActiveRecord::Migration[6.1]
  def change
    change_column_null :user_profiles, :prefecture_code, false, ''
    change_column_null :user_profiles, :age, false, ''
    change_column_null :user_profiles, :proposed_site, true, ''
    change_column_null :user_profiles, :content, true, ''
  end
end
