class AddRoleToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :role, :integer
    add_column :users, :role, :integer
  end
end
