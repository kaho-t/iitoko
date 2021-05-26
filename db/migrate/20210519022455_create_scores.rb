class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.integer :nature
      t.integer :accessibility
      t.integer :budget
      t.integer :job_support
      t.integer :family_support
      t.integer :culture
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
