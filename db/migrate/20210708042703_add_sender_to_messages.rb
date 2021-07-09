class AddSenderToMessages < ActiveRecord::Migration[6.1]
  def change
    remove_column :messages, :sent_from, :integer
    add_reference :messages, :sender, polymorphic: true
  end
end
