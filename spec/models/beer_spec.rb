require 'spec_helper'

describe Beer do
  before(:each) do
    @brewery = Factory(:brewery)
    @attr = {
      :brewery_id => @brewery,
      :style => "Ale",
      :name => "Brown Shugga",
      :abv => 9.99,
      :description => "As good as it sounds!"
    }
  end
  
  it "should create a new instance with valid attributes" do
    Beer.create!(@attr)
  end
  
  describe "brewery associations" do
    before(:each) do
      attr_without_brewery = @attr.reject {|k,v| k == :brewery_id}
      @beer = @brewery.beers.create!(attr_without_brewery)
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
      attr_without_brewery = @attr.reject {|k,v| k == :brewery_id}
      Beer.new(attr_without_brewery).should_not be_valid
    end
    
    it "should require a non-blank stlye" do
      Beer.new(@attr.merge :style => "   ").should_not be_valid
    end
    
    it "should require a non-blank name" do
      Beer.new(@attr.merge :name => "   ").should_not be_valid
    end
  end
end
