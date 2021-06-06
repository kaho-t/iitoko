class ChangeDataCrimeRateToProfile < ActiveRecord::Migration[6.1]
  def change
    change_column :profiles, :crime_rate, :float
  end
end
