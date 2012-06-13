class Ride < ActiveRecord::Base
  attr_accessible :date, :distance, :name
  
  validates_presence_of :distance, :date
end
