class Membership < ActiveRecord::Base
  belongs_to :team, inverse_of: :memberships, :counter_cache => true
  belongs_to :user, inverse_of: :memberships
  has_many :rides, through: :user
  has_one :competition, through: :team

  validates :team, associated: true, presence: true
  validates :user, associated: true, presence: true

  attr_accessible :team_id, :team, :user_id, :user, :approved

  before_save :update_approved_at

  def participation_percent
    @participation_percent ||= (100.0 * actual_rides / possible_rides).round(1)
  end

  private
  def update_approved_at
    if approved_changed? && approved?
      self.approved_at = Time.now
    end
  end

  def actual_rides
    # here be dragons
    dated_rides = rides.group_by(&:date)
    dated_rides.inject(0) do |total, (_, rides)|
      total + [2, rides.inject(0) {|total, r| total + (r.is_round_trip ? 2 : 1)}].min
    end
  end

  def possible_rides
    2 * competition.work_days
  end
end
