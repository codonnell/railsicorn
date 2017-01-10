class AddSignupToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :signup, :datetime
  end
end
