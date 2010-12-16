require 'spec_helper'

describe "LayoutLinks" do

  describe "GET /layout_links" do

    it "should have a Home page at '/'" do
      get '/'
      response.should have_selector('title', :content => "Home")
    end

    it "should have the right links on the layout" do
      visit root_path
      click_link "Home"
      response.should have_selector('title', :content => "Home")
    end

  end
end
