require 'spec_helper'

describe Brewery do
  before(:each) do
    @attr = { :name => "Brauhaus" }
  end
  
  it "should create a new instance given valid attributes" do
    Brewery.create!(@attr)
  end
  
  it "should require a name" do
    no_name_brewery = Brewery.new(@attr.merge(:name => ''))
    no_name_brewery.should_not be_valid
  end
  
  it "should reject duplicate names" do
    Brewery.create!(@attr)
    brewery_with_duplicate_name = Brewery.new(@attr)
    brewery_with_duplicate_name.should_not be_valid
  end
  
  it "should reject names identical up to case" do
    uppercase_name = @attr[:name].upcase
    Brewery.create!(@attr.merge(:name => uppercase_name))
    brewery_with_duplicate_name = Brewery.new(@attr)
    brewery_with_duplicate_name.should_not be_valid
  end
  
  describe "beer associations" do
    before(:each) do
      @brewery = Brewery.create(@attr)
      @beer1 = Factory(:beer, :brewery => @brewery, :name => "Imperial Stout")
      @beer2 = Factory(:beer, :brewery => @brewery, :name => "Hop Stoopid")
    end
    
    it "should have a beers attribute" do
      @brewery.should respond_to(:beers)
    end
    
    it "should have the right beers in the right order" do
      @brewery.beers.should == [@beer2, @beer1]
    end
    
    it "should destroy associated beers on delete" do
      @brewery.destroy
      [@beer1, @beer2].each do |beer|
        Beer.find_by_id(beer.id).should be_nil
      end
    end
  end
end
