class AddNewPersonalStatsToPlayerInfoUpdates < ActiveRecord::Migration[5.0]
  def change
    add_column :player_info_updates, :best_damage, :integer
    add_column :player_info_updates, :kill_streak, :integer
    add_column :player_info_updates, :one_hit_kills, :integer
    add_column :player_info_updates, :money_invested, :integer, limit: 8
    add_column :player_info_updates, :invested_profit, :integer, limit: 8
  end
end
