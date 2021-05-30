class AddColumnsToLocals < ActiveRecord::Migration[6.1]
  def change
    add_column :locals, :provider, :string
    add_column :locals, :uid, :string
  end
end
