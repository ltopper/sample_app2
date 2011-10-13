class CreateMicroposts < ActiveRecord::Migration
  def self.up
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id
      
      # Add the magical create_at and updated_at columns
      t.timestamps
    end
                # included index ability to retrieve user_id and created_at
                # Allow Active record to user both keys that the same time.
                add_index :microposts, [:user_id, :created_at]
  end

  def self.down
    drop_table :microposts
  end
end
