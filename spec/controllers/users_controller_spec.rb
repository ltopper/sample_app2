require 'spec_helper'

describe UsersController do
  # Tell it to render the view (built in to the integration, but not the test),
    # this is when you test the view itself, in the "it should have..." section below
  render_views

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
