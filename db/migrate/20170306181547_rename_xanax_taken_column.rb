class RenameXanaxTakenColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :player_info_updates, :xan_taken, :xanax_taken
  end
end
