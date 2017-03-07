class AddTornIdIndices < ActiveRecord::Migration[5.0]
  def change
    add_index :attacks, :torn_id
    add_index :players, :torn_id
    add_index :attacks, :timestamp
  end
end
