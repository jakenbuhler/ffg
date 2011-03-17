require 'spec_helper'

describe "Beers" do
  before(:each) do
    user = Factory(:user)
    visit signin_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button
  end
  
  describe "GET /beers" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get beers_path
      response.status.should be(200)
    end
  end
end
