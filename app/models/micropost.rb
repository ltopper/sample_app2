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
end
