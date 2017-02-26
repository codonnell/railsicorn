class AddSpouseForeignKeyToPlayerInfoUpdates < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :player_info_updates, :players, column: :spouse_id
  end
end
