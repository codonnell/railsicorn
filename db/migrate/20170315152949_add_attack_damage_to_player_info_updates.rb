class AddAttackDamageToPlayerInfoUpdates < ActiveRecord::Migration[5.0]
  def change
    add_column :player_info_updates, :attack_damage, :integer, limit: 8
  end
end
