class MicropostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]

  before_filter :authorized_user, :only => :destroy
  
  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      # reset @feed_items
      @feed_items = []
      render 'pages/home'
    end
  end
  
  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end
  
  private
    
    def authorized_user
      # Ensures that the search only looks for microposts belonging to the current
      #   user. Always run look-ups by association. Instead of using Micropost.find_by_id(params[:id])
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end
    
      # # With exceptions...it looks like:
      # def authorized_user
      #   @micropost = current_user.microposts.find(params[:id])
      # rescue
      #   redirect_to root_path
      # end
  
end