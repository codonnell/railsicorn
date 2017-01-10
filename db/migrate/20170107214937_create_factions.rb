class CreateFactions < ActiveRecord::Migration[5.0]
  def change
    create_table :factions do |t|
      t.integer :torn_id
      t.string :api_key

      t.timestamps
    end
  end
end
