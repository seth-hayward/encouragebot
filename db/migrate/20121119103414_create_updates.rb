class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.string :value
      t.integer :goal_id

      t.timestamps
    end
    add_index :updates, :value
  end
end
