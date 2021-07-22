class ChangeColumnToUserProfiles < ActiveRecord::Migration[6.1]
  def change
    change_column_null :user_profiles, :prefecture_code, false, 0
    change_column_null :user_profiles, :age, false, 0
    change_column_null :user_profiles, :proposed_site, false, ''
    change_column_null :user_profiles, :job, false, ''
    change_column_null :user_profiles, :family_structure, false, ''
    change_column_null :user_profiles, :timing, false, ''
    change_column_null :user_profiles, :content, false, ''

  end
end
