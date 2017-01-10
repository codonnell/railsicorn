class AddFactionToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_reference :players, :faction, foreign_key: true
  end
end
