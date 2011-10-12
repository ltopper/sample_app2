class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # This includes the SessionsHelper functions in ALL Controllers, as they are
  # each < ApplicationController
  include SessionsHelper
  
end
