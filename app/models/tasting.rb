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
  validates :rating,    :presence => true,
                        :numericality => { :only_integer => true,
                                           :greater_than_or_equal_to => 0,
                                           :less_than_or_equal_to => 5 }
  validates :tasted_on, :presence => true
end
