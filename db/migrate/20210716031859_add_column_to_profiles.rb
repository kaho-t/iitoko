class AddColumnToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :catchphrase, :string
  end
end
