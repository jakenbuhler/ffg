# == Schema Information
# Schema version: 20110317141610
#
# Table name: tastings
#
#  id         :integer         not null, primary key
#  beer_id    :integer
#  taster_id  :integer
#  rating     :integer
#  comments   :string(255)
#  tasted_on  :date
#  created_at :datetime
#  updated_at :datetime
#

class Tasting < ActiveRecord::Base
  attr_accessible :beer_id, :taster_id, :rating, :comments, :tasted_on

  belongs_to :beer
  belongs_to :taster, :class_name => 'User', :foreign_key => 'taster_id'

  validates :beer_id,   :presence => true
  validates :taster_id, :presence => true
  validates :rating,    :presence => true
  validates :tasted_on, :presence => true
end
