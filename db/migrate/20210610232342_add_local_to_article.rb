class AddLocalToArticle < ActiveRecord::Migration[6.1]
  def change
    add_reference :articles, :local, null: false, foreign_key: true
    add_index :articles, [:local_id, :created_at]
  end
end
