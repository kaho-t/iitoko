class AddPrefectureCodeToLocals < ActiveRecord::Migration[6.1]
  def change
    add_column :locals, :prefecture_code, :integer
  end
end
