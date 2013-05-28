class Ride < ActiveRecord::Base
  default_scope order('date DESC, created_at DESC')
  belongs_to :rider, class_name: "User"

  validates :date, presence: true
  validates :bike_distance, :numericality => { :greater_than_or_equal_to => 0, allow_nil: true }
  validates :bus_distance, :numericality => { :greater_than_or_equal_to => 0, allow_nil: true }
  validates :walk_distance, :numericality => { :greater_than_or_equal_to => 0, allow_nil: true }
  validates :rider, presence: true

  validate :validate_date_not_in_future
  validate :validate_distance_presence
  validate :validate_total_distance

  attr_accessible :date, :description, :bike_distance, :bus_distance,
                  :walk_distance, :rider_id, :is_round_trip, :work_trip

  def total_distance
    [bike_distance, bus_distance, walk_distance].compact.sum
  end

  private

  def validate_distance_presence
    if bike_distance.blank? && bus_distance.blank? && walk_distance.blank?
      errors.add :bike_distance, "a distance is required"
      errors.add :bus_distance, "a distance is required"
      errors.add :walk_distance, "a distance is required"
    end
  end

  def validate_total_distance
    if total_distance <= 0
      errors.add :bike_distance, "total distance must be greater than zero"
      errors.add :bus_distance, "total distance must be greater than zero"
      errors.add :walk_distance, "total distance must be greater than zero"
    end
  end

  def validate_date_not_in_future
    if date? && date.to_date > Date.today
      errors.add :date, "can't be in the future"
    end
  end
end
