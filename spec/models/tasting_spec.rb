require 'spec_helper'

describe Tasting do
  before(:each) do
	  @beer = Factory(:beer)
	  @taster = Factory(:user)
	  @attr = {
		  :beer_id => @beer,
		  :taster_id => @taster,
		  :rating => 3,
		  :comments => 'Zehr gut!',
		  :tasted_on => '2012-01-01'
		}
	end
	
	it 'should save with valid attributes' do
		Tasting.create!(@attr)
	end
	
	it 'should not allow non-integer ratings' do
		Tasting.create(@attr.merge(:rating => 'String')).should_not be_valid
		Tasting.create(@attr.merge(:rating => 1.5)).should_not be_valid
	end
	
	it 'should not allow ratings above 5' do
		Tasting.create(@attr.merge(:rating => 6)).should_not be_valid
	end
	
	it 'should not allow ratings below 0' do
		Tasting.create(@attr.merge(:rating => -1)).should_not be_valid
	end
end
