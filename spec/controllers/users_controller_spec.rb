require 'spec_helper'

describe UsersController do
  # Tell it to render the view (built in to the integration, but not the test),
    # this is when you test the view itself, in the "it should have..." section below
  render_views

  
# Testing the show particular user functionality

  describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should be successful" do
      get :show, :id => @user # or @user.id, but rails automatically converts this
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, :id => @user 
      # assigns takes a symbol argument and returns the value of the corresponding
      # instance variable in the controller action 
      assigns(:user).should == @user
    end
    
    # Check for user name in title
    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.name)
    end
    
    # check for username in heading
    it "should include the user's name" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name)
    end
    
    it "should have a profile image" do
      get :show, :id => @user
      # h1>img makes sure that the img tag is inside of the h1 tag
      response.should have_selector("h1>img", :class => "gravatar")
    end
  end
  
# Test the new users page
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response. should have_selector("title", :content => "Sign up")
    end
  end
end
