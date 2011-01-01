# == Schema Information
# Schema version: 20101231221640
#
# Table name: breweries
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Brewery < ActiveRecord::Base
  attr_accessible :name
  
  validates :name, :presence   => true,
                   :uniqueness => { :case_sensitive => false }
end
