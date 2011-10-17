class UsersController < ApplicationController
  # Sets a filter to call the :authenticate method, before allowing either :edit, or :update
  before_filter :authenticate, :except => [:show, :new, :create]
  
  # Sets a filter to only allow the correct user, to edit their own profile
  before_filter :correct_user, :only => [:edit, :update]
  
  # Sets a filter that a user must be an admin to destroy an account
  before_filter :admin_user,   :only => :destroy
  
  
# _________________ METHODS

# Show user method  
  def show
    # This pulls out the id from the URL - which is common in rails
    @user = User.find(params[:id])
    # Set the tile of each user to be their username
    @title = @user.name
    @microposts= @user.microposts.paginate(:page => params[:page])
  end
  
  
# Definition of the index page that shows all users
  def index
    @title = "All users"
    # paginate the users and turn the huge User.all array into 
    # => many objects to be displayed by default 30 at a time.
    @users = User.paginate(:page => params[:page])
  end
    
  def new
    # Can only create a new user if the current_user is not signed in
    redirect_to(root_path) unless current_user.nil?
    @title = "Sign up"
    # have to define @user for the 'new' controller action to 
    # be used in new.html.erb
    @user = User.new
  end

  
# create, Method: create a new user - else return failure  
  def create
    # Can only create a new user if the current_user is not signed in
    redirect_to(root_path) unless current_user.nil?
    
    # @user = User.new(:name => "Foo Bar", :email => "foo@invalid",
    #                  :password => "dude", :password_confirmation => "dude")....or whatever the entries are
    @user = User.new(params[:user])
    
    
    
    # Handle a successful save
    if @user.save  
      # log the user in after sign up success
      sign_in @user
      # Create admin account
      if @user.name == "Louis Topper"
        @user.toggle!(:admin)
      end
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      
    # Sign up failed  
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
  
  
# Destroy user function
  def destroy
    # user_to_destroy = User.find(params[:id])
    # # redirect_to(users_path) unless !@user_to_destroy.admin?
    # unless current_user?(user_to_destroy)
    #   user_to_destroy.destroy
    #   flash[:success] = "User destroyed."
    # end
    # redirect_to users_path
    
     User.find(params[:id]).destroy
     flash[:success] = "User destroyed."
     redirect_to users_path
  end
  
  
# Edit profile functionality
  def edit
    @title = "Edit user"
  end

# Update profile   
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user # Rails/ruby idiom, will sent to /user/idnumber
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
# Following and followers
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  private
  
    
    def correct_user
      @user = User.find(params[:id])
      # if the current user is the correct user, then continue on editing, otherwise, send to root_path
      redirect_to(root_path) unless current_user?(@user)
    end
    
    
end
