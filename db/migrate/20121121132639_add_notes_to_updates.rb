class AddNotesToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :notes, :string
  end
end
