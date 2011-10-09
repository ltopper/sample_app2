class CreateUsers < ActiveRecord::Migration
  def self.up
    # rails method 'create_table'
    create_table :users do |t|
      t.string :name
      t.string :email
      
      # two timestamps added to the database: created_at and updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
