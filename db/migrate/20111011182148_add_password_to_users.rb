class AddPasswordToUsers < ActiveRecord::Migration
  def self.up
    # add_column method to append an encrypted password to the users table (Fig. 7.2)
    add_column :users, :encrypted_password, :string
  end

  def self.down
    remove_column :users, :encrypted_password
  end
end
