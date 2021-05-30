class AddLocalIdToScores < ActiveRecord::Migration[6.1]
  def change
    add_reference :scores, :local, foreign_key: true
  end
end
