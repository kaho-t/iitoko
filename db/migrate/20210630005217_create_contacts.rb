class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :category
      t.text :content

      t.timestamps
    end
  end
end
