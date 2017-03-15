class AddAttackMissesToPlayerInfoUpdates < ActiveRecord::Migration[5.0]
  def change
    add_column :player_info_updates, :attack_misses, :integer
  end
end
