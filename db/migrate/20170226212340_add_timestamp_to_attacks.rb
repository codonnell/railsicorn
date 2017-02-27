class AddTimestampToAttacks < ActiveRecord::Migration[5.0]
  def change
    add_column :attacks, :timestamp, :datetime
  end
end
