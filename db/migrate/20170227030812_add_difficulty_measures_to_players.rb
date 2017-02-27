class AddDifficultyMeasuresToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :least_stats_beaten_by, :float
    add_column :players, :most_stats_defended_against, :float
  end
end
