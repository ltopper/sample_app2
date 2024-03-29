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
require 'digest'
class User < ActiveRecord::Base
  # Don't want :admin to be something that can be assigned, so we leave it off accessible,
  #   and accessor lists
  
  # Enable the writing of an encrypted password
  attr_accessor :password
  
  # Define which entities may be modified by users
  attr_accessible :name, :email, :password, :password_confirmation
  
  # Define has_many relationship: users have many microposts
  #     The belongs_to has_many pair create a number of usable methods
  #     :dependent => :destroy, makes it so if a user is destroyed, so are their microposts
  has_many :microposts, :dependent => :destroy
  has_many :relationships, :foreign_key => "follower_id", # need to define, as for above, it's default is user_id
                           # destroying a user, should destroy the relationships as well.
                           :dependent => :destroy
  
  # Define the has many following relationship, and override the followed (followeds) call
  #     which was automatically generated, and make it more legible by calling it following
  has_many :following, :through => :relationships, :source => :followed
  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower
  
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
                    
  # Automatically create the virtual attribute 'password_confirmation',
  # while verifying that it matches the password attribute at the same time
  # (also ensure the password is within a particular range)
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }
  
  # before user is saved to the database - we encrypt the password by calling our method
  # encrypt_password defined below
  before_save :encrypt_password
  
  def has_password?(submitted_password)
      # Compare encrypted_password with the encrypted version of 
      # submitted_password
      encrypted_password == encrypt(submitted_password)
  end
# THE NEXT TWO FUNCTIONS HAVE COMMENTED OUT FUNCTIONS THAT ALSO WORK,
# THEY ARE THERE FOR CLARITY SAKE
  # def self.authenticate(email, submitted_password)
  #   user = find_by_email(email)
  #   return nil if user.nil?
  #   return user if user.has_password?(submitted_password)
  # end
  
  def self.authenticate(email, submitted_password)
      user = find_by_email(email)
      user && user.has_password?(submitted_password) ? user : nil
  end
  
  # def self.authenticate_with_salt(id, cookie_salt)
  #   user = find_by_id(id)
  #   return nil  if user.nil?
  #   return user if user.salt == cookie_salt
  # end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    # boolean? ? do_one_thing : do_something_else
    # Here we test if user.salt == cookie_salt, and return either true (user) or false (nil)
    (user && user.salt == cookie_salt) ? user : nil
  end

# Method definition for a micropost feed
  def feed
    Micropost.from_users_followed_by(self)
  end
  
# Following model relationships and methods
  def following?(followed)
    relationships.find_by_followed_id(followed)
  end
  
  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end
  
  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end 
  
  
  
  
  private # There is no 'end' after private - lesson learned

    def encrypt_password
      # self = refers to the object itself, which in the User model is the user.
      # this assigns the attribute 'encrpted_password' to the user 
      # could write: self.encrypted_password = encrypt(self.password), but it's unecessary
        # Create salt - an encryption method based on the Time stamp Time.new.utc, only
        # if it's the correct password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
      
                    
end
