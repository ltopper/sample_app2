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
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    # Test for titles
    # checks to see that the content inside the <title></title> tags is "Ruby on Rails Tutorial Sample App | Home"
    # can be a substring as well to return true, i.e. only :content => "| Home"
    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                      :content => 
                          @base_title + " | Home")
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
