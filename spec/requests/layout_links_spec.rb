require 'spec_helper'

describe "LayoutLinks" do
  before(:each) do
    @user = Factory(:user)
    visit signin_path
    fill_in :email,    :with => @user.email
    fill_in :password, :with => @user.password
    click_button
  end
  
  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "About")
  end

  it "should have an Administration page at '/admin'" do
    get '/admin'
    response.should have_selector('title', :content => "Admin")
  end

  it "should have the right links on the layout" do
    visit root_path
    response.should have_selector("a", :href => signout_path)
    click_link "About"
    response.should have_selector('title', :content => "About")
    click_link "Beers"
    response.should have_selector('title', :content => "Beers")
    click_link "Profile"
    response.should have_selector('title', :content => @user.name)
    click_link "Admin"
    response.should have_selector('title', :content => "Admin")
  end
end
