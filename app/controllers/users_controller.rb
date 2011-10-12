class UsersController < ApplicationController
  
  def show
    # This pulls out the id from the URL - which is common in rails
    @user = User.find(params[:id])
    # Set the tile of each user to be their username
    @title = @user.name
  end
  
  def new
    @title = "Sign up"
    # have to define @user for the 'new' controller action to 
    # be used in new.html.erb
    @user = User.new
  end
  
# create, Method: create a new user - else return failure  
  def create
    # @user = User.new(:name => "Foo Bar", :email => "foo@invalid",
    #                  :password => "dude", :password_confirmation => "dude")....or whatever the entries are
    @user = User.new(params[:user])
    if @user.save
      # Handle a successful save.
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      # Reset invalid user.password, and it's confirmation
      @user.password = ""
      @user.password_confirmation = ""
      # Send back to "Sign up"
      @title = "Sign up"
      # Render the 'new.html.erb', the new user sign up page
      render 'new'
      
    end
  end
end
