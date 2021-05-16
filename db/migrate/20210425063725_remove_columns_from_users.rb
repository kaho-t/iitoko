class RemoveColumnsFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :password_digest, :string
    remove_column :users, :remember_digest, :string
    remove_column :users, :activation_digest, :string
    remove_column :users, :activated, :boolearn
    remove_column :users, :activated_at, :datetime
  end
end
