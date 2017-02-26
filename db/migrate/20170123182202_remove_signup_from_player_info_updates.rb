class RemoveSignupFromPlayerInfoUpdates < ActiveRecord::Migration[5.0]
  def change
    remove_column :player_info_updates, :signup, :datetime
  end
end
