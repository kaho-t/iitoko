class ChangeDataOfPopulationAndTemperatureToProfile < ActiveRecord::Migration[6.1]
  def change
    change_column :profiles, :temperature, :float
    change_column :profiles, :population, :integer
  end
end
