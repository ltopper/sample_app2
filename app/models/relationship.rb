class Relationship < ActiveRecord::Base
  # :followed_id accessible to users, so that they may select who they 
  #   follow and unfollow
  attr_accessible :followed_id
  
  belongs_to :follower, :class_name => "User" #rails infers the foreign keys follower_id
  belongs_to :followed, :class_name => "User"
  
  validates :follower_id, :presence => true
  validates :followed_id, :presence => true
end
