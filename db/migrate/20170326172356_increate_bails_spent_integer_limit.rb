class IncreateBailsSpentIntegerLimit < ActiveRecord::Migration[5.0]
  def change
    change_column :player_info_updates, :bails_spent, :integer, limit: 8
  end
end
