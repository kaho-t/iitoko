class ChangeDataTemperatureToProfile < ActiveRecord::Migration[6.1]
  def change
    change_column :profiles, :temperature, :float
  end
end
