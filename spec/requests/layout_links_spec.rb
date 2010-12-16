require 'spec_helper'

describe "LayoutLinks" do
  describe "GET /layout_links" do
    it "should have a Home page at '/'" do
      get '/'
      response.should have_selector('title', :content => "Home")
    end

    it "should have a Sign Up page at '/signup'" do
      get '/signup'
      response.should have_selector('title', :content => "Sign Up")
    end

    it "should have the right links on the layout" do
      visit root_path
      click_link "Home"
      response.should have_selector('title', :content => "Home")
      click_link "Sign Up"
      response.should have_selector('title', :content => "Sign Up")
    end
  end
end
