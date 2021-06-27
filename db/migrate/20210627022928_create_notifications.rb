class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :notice_to, null: false
      t.boolean :is_for_user, null:false
      t.integer :notice_from, null: false
      t.boolean :is_from_user, null: false
      t.string :action, default: '', null: false
      t.references :bookmark, default: '', null: true, foreign_key: true
      t.references :talkroom, default: '', null: true, foreign_key: true
      t.references :message, default: '', null: true, foreign_key: true
      t.references :article, default: '', null: true, foreign_key: true
      t.boolean :is_checked, default: false, null: false

      t.timestamps
    end
    add_index :notifications, [:notice_to, :is_for_user]
    add_index :notifications, [:notice_from, :is_from_user]
  end
end
