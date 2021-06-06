class ChangeDataOfPopulationToProfile < ActiveRecord::Migration[6.1]
  def change
    change_column :profiles, :temperature, :integer
  end
end
