require 'spec_helper'

describe Beer do
  before(:each) do
    @brewery = Factory(:brewery)
    @attr = {
      :style => "Ale",
      :name => "Brown Shugga",
      :abv => 9.99,
      :description => "As good as it sounds!"
    }
  end
  
  it "should create a new instance with valid attributes" do
    @brewery.beers.create!(@attr)
  end
  
  describe "brewery associations" do
    before(:each) do
      @beer = @brewery.beers.create!(@attr)
    end
    
    it "should have a brewery attribute" do
      @beer.should respond_to(:brewery)
    end
    
    it "should have the right associated brewery" do
      @beer.brewery_id.should == @brewery.id
      @beer.brewery.should == @brewery
    end
  end
  
  describe "validations" do
    it "should require a brewery_id" do
      Beer.new(@attr).should_not be_valid
    end
    
    it "should require a non-blank stlye" do
      @brewery.beers.build(:style => "   ", :name => "IPA", :abv => 6.7).should_not be_valid
    end
    
    it "should require a non-blank name" do
      @brewery.beers.build(:style => "Ale", :name => "   ", :abv => 9.99).should_not be_valid
    end
  end
end
