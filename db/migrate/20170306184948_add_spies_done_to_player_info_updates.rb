class AddSpiesDoneToPlayerInfoUpdates < ActiveRecord::Migration[5.0]
  def change
    add_column :player_info_updates, :spies_done, :integer
  end
end
