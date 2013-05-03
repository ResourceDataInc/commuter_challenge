class Ride < ActiveRecord::Base
  belongs_to :rider, class_name: "User"

  validates :date, presence: true
  validates :description, presence: true
  validates :distance, presence: true, :numericality => { :greater_than => 0 }
  validates :rider, presence: true

  attr_accessible :date, :description, :distance, :rider_id, :is_round_trip
end
