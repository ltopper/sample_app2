# THIS GEM ANNOTATES OUR MODEL FOR US!
# group :development do
#   gem 'annotate', '2.4.0'
# end


# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  # Define which entities may be modified by users
  attr_accessible :name, :email
  
  # Define email_regex which parses for acceptible email addresses
        # regex - regular expression see rubular.com
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  # Validation settings to ensure that a user has both a name and an email
  validates :name, :presence => true,
                   :length => { :maximum => 50 }
  # the function read is essentially - validate(:name, :presence => true)
  validates :email, :presence => true,
                    # ensure valid email address
                    :format => { :with => email_regex },
                    :uniqueness => {:case_sensitive => false}
                    
end
