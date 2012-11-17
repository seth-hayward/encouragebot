class AddUserTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_type, :integer, default: 7
  end
end
