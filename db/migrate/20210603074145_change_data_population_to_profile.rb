class ChangeDataPopulationToProfile < ActiveRecord::Migration[6.1]
  def change
    change_column :profiles, :population, :float
  end
end
