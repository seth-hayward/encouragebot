class AddStatusToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :status, :integer, default: 1
  end
end
