class AddAttackHitsToPlayerInfoUpdates < ActiveRecord::Migration[5.0]
  def change
    add_column :player_info_updates, :attack_hits, :integer
  end
end
