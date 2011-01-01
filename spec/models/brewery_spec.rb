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
end
