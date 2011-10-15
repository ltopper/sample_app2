class Micropost < ActiveRecord::Base
  # Ensures that the :content component of 'microposts' is the only
  #   editable element of the microposts data model
  #   i.e. one can't edit the user_id of a micropost via: 
  #   Micropost.new(:content => "foo bar", :user_id => 17)
  attr_accessible :content
  
  # Define the 'belongs_to' user relationship (11.6)
  belongs_to :user
  
  # Validate presence of characters, limited lengt of micropost, 
  #   and that there is an associated user_id
  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
  
  # Set default ordering to place the newest post at the top
  default_scope :order => 'microposts.created_at DESC' #DESC is SQL for descending order

  # Return microposts from the users being followed by the given user.
  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  private

    # Return an SQL condition for users followed by the given user.
    # We include the user's own id as well.
    def self.followed_by(user)
      following_ids = %(SELECT followed_id FROM relationships
                        WHERE follower_id = :user_id)
      where("user_id IN (#{following_ids}) OR user_id = :user_id",
            { :user_id => user })
    end
    
end
