class AddImageToLocals < ActiveRecord::Migration[6.1]
  def change
    add_column :locals, :image, :string
  end
end
