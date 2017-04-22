class UniqifyTornIdIndexes < ActiveRecord::Migration[5.0]
  def change
    remove_index :attacks, column: :torn_id
    remove_index :players, column: :torn_id
    add_index :attacks, :torn_id, unique: true
    add_index :players, :torn_id, unique: true
    add_index :factions, :torn_id, unique: true
  end
end
