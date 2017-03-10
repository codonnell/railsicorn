class IncreaseLargestMugIntegerLimit < ActiveRecord::Migration[5.0]
  def change
    change_column :player_info_updates, :largest_mug, :integer, limit: 8
  end
end
