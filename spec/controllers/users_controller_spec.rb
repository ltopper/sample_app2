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
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign up")
    end
    
    it "should have a name field" do
      get :new
      response.should have_selector("input[name='user[name]'][type='text']")
    end
    
    it "should have an email field" do
      get :new
      response.should have_selector("input[name='user[email]'][type='text']")
    end
    
    # The passwords are of a different type of entry field.
    # For security, these types are obscured, thus one must call that out
    it "should have a password field" do
      get :new
      response.should have_selector("input[name='user[password]'][type='password']")
    end
    
    it "should have a password confirmation field" do
      get :new
      response.should have_selector("input[name='user[password_confirmation]'][type='password']")
    end
  end
  
# Test for invalid new user submissions
  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = {:name => "", :email => "", :password => "", :password_confirmation => ""}
      end
      
      it "should not create a user" do
        # verify that a failed create action doesn’t create a user in the database.
        lambda do
          post :create, :user => @attr
         # change(User, :count) - returns the change in number of users in the database
        end.should_not change(User, :count)
      end
      
      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Sign up")
      end
      
      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end
    
    # test for successful user submissions
    describe "success" do
        
      before(:each) do
        @attr = { :name => "New User", :email => "user@example.com",
                  :password => "foobar", :password_confirmation => "foobar" }
      end
        
      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      
      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end 
        
      it "should redirect to the user show page" do
        post :create, :user => @attr
         # normally, the inside could just be @user, because rails recognizes it, but Rspec doesn't
        response.should redirect_to(user_path(assigns(:user)))
      end
      
      it "should have a welcome message" do
        post :create, :user => @attr
        #/i makes it case insensitive
        flash[:success].should =~ /welcome to the sample app/i
      end
      
    end
  end
end
