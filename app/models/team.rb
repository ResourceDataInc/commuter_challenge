class Team < ActiveRecord::Base
  belongs_to :captain, class_name: "User"
  has_many :memberships, inverse_of: :team, :dependent => :destroy
  has_many :members, through: :memberships, source: :user
  has_many :rides, through: :members
  has_one :competitor, inverse_of: :team, :dependent => :destroy
  has_one :competition, through: :competitor

  validates :name, presence: true
  validates :captain, presence: true
  validates :business_size, presence: true, :numericality => { :greater_than => 0 }

  attr_accessible :captain_id, :description, :name, :business_size

  scope :by_name, -> { order :name }

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def approved_users
    memberships.where(approved: true)
  end

  def participation_percent
    @participation_percent ||= competition.calculations.team_participation_percent(business_size, rides)
  end

  def team_rides
    @team_rides ||= competition.calculations.team_actual_rides(rides)
  end
end
