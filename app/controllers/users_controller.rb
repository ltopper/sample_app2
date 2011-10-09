class UsersController < ApplicationController
  
  def show
    # This pulls out the id from the URL - which is common in rails
    @user = User.find(params[:id])
  end
  
  def new
    @title = "Sign up"
  end

end
