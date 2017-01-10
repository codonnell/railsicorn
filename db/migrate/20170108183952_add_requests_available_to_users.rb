class AddRequestsAvailableToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :requests_available, :integer
  end
end
