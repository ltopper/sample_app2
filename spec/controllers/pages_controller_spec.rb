require 'spec_helper'

describe PagesController do
  
  # render views inside the controller tests, ensures that the pages are really there if the test passes
  render_views


  before(:each) do
    #
    # Define @base_title here.
    @base_title = "Ruby on Rails Tutorial Sample App"
    #
  end
     
    
    

  describe "GET 'home'" do

     describe "when not signed in" do

       before(:each) do
         get :home
       end

       it "should be successful" do
         response.should be_success
       end

       it "should have the right title" do
         response.should have_selector("title",
                                       :content => "#{@base_title} | Home")
       end
     end

     describe "when signed in" do
 
       before(:each) do
         @user = test_sign_in(Factory(:user))
         other_user = Factory(:user, :email => Factory.next(:email))
         other_user.follow!(@user)
       end

       it "should have the right follower/following counts" do
         get :home
         response.should have_selector("a", :href => following_user_path(@user),
                                            :content => "0 following")
         response.should have_selector("a", :href => followers_user_path(@user),
                                            :content => "1 follower")
       end
     end
   end

  describe "GET 'contact'" do # just a description
    it "should be successful" do # so you can read english
      get 'contact'   # this actually does something
      response.should be_success # verifies that the response was 200, 301 is fail or permanent redirect
    end
    
    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                      :content => 
                          @base_title + " | Contact")
    end
  end

  # Test for the 'about page' which we have not yet created 
  # - HAVE NOW CREATED IT
  describe "GET 'about'" do 
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                      :content => 
                          @base_title + " | About")
    end
  end
  
  describe "GET 'help'" do 
    it "should be successful" do
      get 'help'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'help'
      response.should have_selector("title",
                      :content => 
                          @base_title + " | Help")
    end
  end
  
end
  
