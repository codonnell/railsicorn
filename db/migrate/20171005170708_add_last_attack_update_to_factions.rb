class AddLastAttackUpdateToFactions < ActiveRecord::Migration[5.0]
  def change
    add_column :factions, :last_attack_update, :datetime
  end
end
