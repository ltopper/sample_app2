class UsersController < ApplicationController
  
  def show
    # This pulls out the id from the URL - which is common in rails
    @user = User.find(params[:id])
    # Set the tile of each user to be their username
    @title = @user.name
  end
  
  def new
    @title = "Sign up"
  end

end
