class CreateBattleStatsUpdates < ActiveRecord::Migration[5.0]
  def change
    create_table :battle_stats_updates do |t|
      t.datetime :timestamp
      t.float :strength
      t.float :dexterity
      t.float :speed
      t.float :defense
      t.float :strength_modifier
      t.float :dexterity_modifier
      t.float :speed_modifier
      t.float :defense_modifier
      t.references :player, foreign_key: true
    end
  end
end
