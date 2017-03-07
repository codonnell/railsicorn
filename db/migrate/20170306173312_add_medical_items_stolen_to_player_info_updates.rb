class AddMedicalItemsStolenToPlayerInfoUpdates < ActiveRecord::Migration[5.0]
  def change
    add_column :player_info_updates, :medical_items_stolen, :integer
  end
end
