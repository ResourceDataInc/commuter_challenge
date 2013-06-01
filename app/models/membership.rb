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
    @participation_percent ||= competition.calculations.member_participation_percent(rides)
  end

  def ride_count
    @competition_rides ||= competition.calculations.member_actual_rides(rides)
  end

  private
  def update_approved_at
    if approved_changed? && approved?
      self.approved_at = Time.now
    end
  end
end
