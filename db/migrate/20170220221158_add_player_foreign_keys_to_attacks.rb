class AddPlayerForeignKeysToAttacks < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :attacks, :players, column: :attacker_id
    add_foreign_key :attacks, :players, column: :defender_id
  end
end
