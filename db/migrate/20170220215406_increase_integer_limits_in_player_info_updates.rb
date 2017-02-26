class IncreaseIntegerLimitsInPlayerInfoUpdates < ActiveRecord::Migration[5.0]
  def change
    change_column :player_info_updates, :networth, :integer, limit: 8
    change_column :player_info_updates, :bounty_rewards, :integer, limit: 8
    change_column :player_info_updates, :bounties_spent, :integer, limit: 8
    change_column :player_info_updates, :money_mugged, :integer, limit: 8
    change_column :player_info_updates, :bazaar_profit, :integer, limit: 8
  end
end
