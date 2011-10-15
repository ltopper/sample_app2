# A Rake task for populating the database with sample users
# =>      call it as follows: bundle exec rake db:populate
namespace :db do
  desc "Fill database with sample data"
  # The following ensures that Rake tast has access to the local Rails environment
  # => including the User model and hence, User.create
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
    admin = User.create!(:name => "Example User",
                 :email => "example@railstutorial.org",
                 :password => "foobar",
                 :password_confirmation => "foobar")
    # make the first user an admin             
    admin.toggle!(:admin)
    
    # Create 99 users
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
end
  
def make_microposts
  # use the faker gem to generate 50 posts for each of the six first users
        50.times do
          User.all(:limit => 6).each do |user|
              user.microposts.create!(:content => Faker::Lorem.sentence(5))
          end
        end
  end

# arrange for the first user to follow the next 50 users, 
# and then have users with ids 4 through 41 follow that user back  
def make_relationships
  users = User.all
  user = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end                
                 