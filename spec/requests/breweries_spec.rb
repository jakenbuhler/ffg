require 'spec_helper'

describe "Breweries" do
  describe "create" do
    before(:each) do
      user = Factory(:user)
      visit signin_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_button
    end
    
    describe "failure" do
      it "should not make a new brewery" do
        lambda do
          visit new_brewery_path
          fill_in "Name", :with => ""
          click_button
          response.should render_template('breweries/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(Brewery, :count)
      end
    end
    
    describe "success" do
      it "should make a new brewery" do
        lambda do
          visit new_brewery_path
          fill_in "Name", :with => "Brauhaus"
          click_button
          response.should have_selector("div.flash.success",
                                        :content => "field trip")
          response.should render_template('breweries/show')
        end.should change(Brewery, :count).by(1)
      end
    end
  end
end