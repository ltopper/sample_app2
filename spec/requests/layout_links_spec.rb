require 'spec_helper'

# Tests to ensure links are working properly
describe "LayoutLinks" do
  
    it "should have a Home page at '/'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get '/'
      response.should have_selector('title', :content => "Home")
    end
    
    it "should have a Contact page at '/contact'" do
      get '/contact'
      response.should have_selector('title', :content => "Contact")
    end
    
    it "should have an About page at '/about'" do
      get '/about'
      response.should have_selector('title', :content => "About")
    end
    
    it "should have an About page at '/help'" do
      get '/help'
      response.should have_selector('title', :content => "Help")
    end
    
    it "should have a signup page at '/signup'" do
      get '/signup'
      response.should have_selector('title', :content => "Sign up")
    end
    
    # Tests for a walking tour of the site
    it "should have the right links on the layout" do
      # Starts at / or home...defined by root_path
      visit root_path
      # clicks the link, and checks for the proper 'title' return from the page
      click_link "About"
      # 'title' is the variable it requests, and the content should be "About"
      response.should have_selector('title', :content => "About")
      click_link "Help"
      response.should have_selector('title', :content => "Help")
      click_link "Contact"
      response.should have_selector('title', :content => "Contact")
      click_link "Home"
      response.should have_selector('title', :content => "Home")
      click_link "Sign up now!"
      response.should have_selector('title', :content => "Sign up")
    end
end
