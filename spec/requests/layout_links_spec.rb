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
      click_link "Don't hesitate, sign your life away now!"
      response.should have_selector('title', :content => "Sign up")
    end
    
    describe "when not signed in" do
      it "should have a signin link" do
        visit root_path
        response.should have_selector("a", :href => signin_path,
                                           :content => "Sign in")
      end
    end
    
    describe "when signed in" do
      
      before(:each) do
        @user = Factory(:user)
        visit signin_path
        fill_in :email,       :with => @user.email
        fill_in :password,    :with => @user.password
        click_button
      end
      
      it "should have a signout link" do
        visit root_path
        response.should have_selector("a", :href => signout_path,
                                           :content => "Sign out")
      end
      
      it "should have a profile link" do
        visit root_path
        response.should have_selector("a", :href => user_path(@user),
                                           :content => "Profile")
      end
    end                                  
end
