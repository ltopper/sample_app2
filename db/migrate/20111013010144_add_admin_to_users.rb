class AddAdminToUsers < ActiveRecord::Migration
  def self.up
    # set default value to false (nil)
    add_column :users, :admin, :boolean, :default => false
  end

  def self.down
    remove_column :users, :admin
  end
end
