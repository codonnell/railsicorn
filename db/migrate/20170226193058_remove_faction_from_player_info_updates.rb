class RemoveFactionFromPlayerInfoUpdates < ActiveRecord::Migration[5.0]
  def change
    remove_reference :player_info_updates, :faction
  end
end
