class Ride < ActiveRecord::Base
  belongs_to :user
  attr_accessible :date, :distance, :name, :user
  
  validates_presence_of :distance, :date
end
