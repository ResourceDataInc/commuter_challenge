class Ride < ActiveRecord::Base
  default_scope order('date DESC')
  belongs_to :rider, class_name: "User"

  validates :date, presence: true
  validates :distance, presence: true, :numericality => { :greater_than => 0 }
  validates :rider, presence: true

  validate :validate_date_not_in_future

  attr_accessible :date, :description, :distance, :rider_id, :is_round_trip

  private

  def validate_date_not_in_future
    if date? && date.to_date > Date.today
      errors.add :date, "can't be in the future"
    end
  end
end
