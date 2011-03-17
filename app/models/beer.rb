# == Schema Information
# Schema version: 20110206002936
#
# Table name: beers
#
#  id          :integer         not null, primary key
#  brewery_id  :integer
#  style       :string(255)
#  name        :string(255)
#  abv         :float
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Beer < ActiveRecord::Base
  attr_accessible :brewery_id, :style, :name, :abv, :description
  
  belongs_to :brewery

  has_many :tastings, :dependent => :destroy
  
  default_scope :order => "beers.name"
  
  validates :brewery_id, :presence => true
  validates :style,      :presence => true
  validates :name,       :presence => true
end
