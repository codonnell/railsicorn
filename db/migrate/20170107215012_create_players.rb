class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.integer :torn_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
