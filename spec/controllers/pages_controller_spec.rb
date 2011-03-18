require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'about'" do
    describe "for non-signed-in users" do
      it "should deny access" do
        get 'about'
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end
    
    describe "for signed-in users" do
      before(:each) do
        test_sign_in(Factory(:user))
      end

      it "should be successful" do
        get 'about'
        response.should be_success
      end

      it "should have the right title" do
        get 'about'
        response.should have_selector("title", :content => "About")
      end
    end
  end

  describe "GET 'admin'" do
    describe "for non-signed-in users" do
      it "should deny access" do
        get 'admin'
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end
    
    describe "for signed-in users" do
      before(:each) do
        test_sign_in(Factory(:user))
      end

      it "should be successful" do
        get 'admin'
        response.should be_success
      end
    
      it "should have the right title" do
        get 'admin'
        response.should have_selector("title", :content => "Admin")
      end
    
      it "should link the the users index" do
        get 'admin'
        response.should have_selector("a", :href => users_path)
      end
    
      it "should link the the breweries index" do
        get 'admin'
        response.should have_selector("a", :href => breweries_path)
      end
    
      it "should link the the beers index" do
        get 'admin'
        response.should have_selector("a", :href => beers_path)
      end
    end
  end
end
