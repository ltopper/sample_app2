class RelationshipsController < ApplicationController
  before_filter :authenticate
  
  
  # In the case of an Ajax request, Rails automatically calls a JavaScript Embedded Ruby (.js.erb) 
  # file with the same name as the action, i.e., create.js.erb or destroy.js.erb. As you might guess, 
  # the files allow us to mix JavaScript and Embedded Ruby to perform actions on the current page. 
  # It is these files that we need to create and edit in order to update the user profile page upon 
  # being followed or unfollowed.
  respond_to :html, :js
  
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_with @user
  end
  
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_with @user
  end


### THIS IS WHAT IT WAS - THEN I REFACTORED IT ABOVE IN ex 12.5.2
  # def create
  #    @user = User.find(params[:relationship][:followed_id])
  #    current_user.follow!(@user)
  #    respond_to do |format|
  #      format.html { redirect_to @user }
  #      format.js
  #    end
  #  end
  # 
  #  def destroy
  #    @user = Relationship.find(params[:id]).followed
  #    current_user.unfollow!(@user)
  #    respond_to do |format|
  #      format.html { redirect_to @user }
  #      format.js
  #    end
  #  end
end