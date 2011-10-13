# A Rake task for populating the database with sample users
# =>      call it as follows: bundle exec rake db:populate
namespace :db do
  desc "Fill database with sample data"
  # The following ensures that Rake tast has access to the local Rails environment
  # => including the User model and hence, User.create
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Example User",
                 :email => "example@railstutorial.org",
                 :password => "foobar",
                 :password_confirmation => "foobar")
    # make the first user an admin             
    admin.toggle!(:admin)
    
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
end                 
                 