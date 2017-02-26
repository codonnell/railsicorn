class CreateAttacks < ActiveRecord::Migration[5.0]
  def change
    create_table :attacks do |t|
      t.integer :torn_id
      t.datetime :timestamp_started
      t.datetime :timestamp_ended
      t.references :attacker, references: :player
      t.references :defender, references: :player
      t.string :result
      t.float :respect_gain
    end
  end
end
