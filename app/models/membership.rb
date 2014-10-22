class Membership < ActiveRecord::Base
  belongs_to :team, inverse_of: :memberships, :counter_cache => true
  belongs_to :user, inverse_of: :memberships
  has_many :rides, through: :user
  has_one :competition, through: :team

  validates :team, associated: true, presence: true
  validates :user, associated: true, presence: true
  validates_presence_of :ride_count
  validates_numericality_of :ride_count, greater_than_or_equal_to: 0
  validate :membership_cannot_exceed_business_size, on: :update

  before_save :update_approved_at

  scope :by_username, -> { includes(:user).order("users.username") }
  scope :approved, -> { where(approved: true) }

  private

  def update_approved_at
    if approved_changed? && approved?
      self.approved_at = Time.now
    end
  end
  def membership_cannot_exceed_business_size
    if team.present? && team.memberships.approved.count >= team.business_size
      errors.add(:memberships, "cannot be higher than the business size")
    end
  end
end



