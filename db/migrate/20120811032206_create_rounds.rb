class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :total_votes, :default => 0
      t.string :channel

      t.timestamps
    end
  end
end
