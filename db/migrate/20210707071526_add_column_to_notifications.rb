class AddColumnToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_reference :notifications, :footprint, null: true, default: '', foreign_key: true
  end
end
