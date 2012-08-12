class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.integer :votes, :default => 0
      t.float :percentage, :default => 0
      t.integer :round_id

      t.timestamps
    end
  end
end
