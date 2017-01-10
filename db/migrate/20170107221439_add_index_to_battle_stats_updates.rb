class AddIndexToBattleStatsUpdates < ActiveRecord::Migration[5.0]
  def change
    add_index :battle_stats_updates, :timestamp
  end
end
