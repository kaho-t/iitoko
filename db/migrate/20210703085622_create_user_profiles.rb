class CreateUserProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_profiles do |t|
      t.integer :prefecture_code, default: '', null: true
      t.integer :age, default: '', null: true
      t.string :proposed_site, default: '', null: true
      t.string :job, default: '', null: true
      t.string :family_structure, default: '', null: true
      t.string :timing, default: '', null: true
      t.text :content, null: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
