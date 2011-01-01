require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_selector("title", :content => "Home")
    end
  end

  describe "GET 'admin'" do
    it "should be successful" do
      get 'admin'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'admin'
      response.should have_selector("title", :content => "Admin")
    end
    
    it "should contain links to the right 'index' pages" do
      get 'admin'
      response.should have_selector("a", :href => breweries_path)
      response.should have_selector("a", :href => users_path)
    end
  end
end
