module SessionsHelper
  
  def sign_in(user)
    # cookies hashes have an optional input of 'expire date'
    # cookies[:remember_token] = { :value   => user.id,
    #                              :expires => 20.years.from_now.utc }
    # => Can now access the user by User.find_by_id(cookies[:remember_token])
    # This is also secure, because of the .permanent.signed implementation
    # cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    session[:user_id] = user.id
    
    # Define a current_user to be accessed like so: <%= current_user.name %> and redirect_to current_user
    self.current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    # Set @current_user equal to the remember token - only if
    #   @current_user is undefined
    #   ||= : the or equals command
    # @current_user ||= user_from_remember_token
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def deny_access
    # Store the locatoin every time access is denied, so that it can be recovered
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
    # equiv to:
          # flash[:notice] = "Please sign in to access this page."
          # redirect_to signin_path
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  
  
  private
  # Don't need these with the adjustment from cookies to sessions
  #  http://www.nimweb.it/web-development/ruby-on-rails-web-development/ruby-on-rails-tutorial-exercise-9-6-2-rails-session/
    # def user_from_remember_token
    #   # The * operator allows the passage of a two-element array as an argument
    #   # =>  to a method expecting two variables
    #   User.authenticate_with_salt(*remember_token)
    # end
    # 
    # def remember_token
    #   # if the cookies are not assigned, i.e. are also nil
    #   # => then return an array of nil values
    #   cookies.signed[:remember_token] || [nil, nil]
    # end
    
    def signed_in?
      # if a user is not signed in, return false
      # signed_in? - nope - false
      !current_user.nil?
    end
    
    def sign_out
      # effectively undo the sign-in method
      # cookies.delete(:remember_token)
      session[:user_id] = nil
      self.current_user = nil
    end
    
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def clear_return_to
      session[:return_to] = nil
    end

end
