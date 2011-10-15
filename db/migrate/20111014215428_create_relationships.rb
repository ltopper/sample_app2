class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    # add index since we will be finding relationships by follower_id and followed_id
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id

    # Composite index, enforce uniqueness pairs, so that a user can't follow another more than once
    add_index :relationships, [:follower_id, :followed_id], :unique => true
  end

  def self.down
    drop_table :relationships
  end
end
