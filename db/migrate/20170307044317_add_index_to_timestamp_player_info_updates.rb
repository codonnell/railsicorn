class AddIndexToTimestampPlayerInfoUpdates < ActiveRecord::Migration[5.0]
  def change
    add_index :player_info_updates, :timestamp
  end
end
