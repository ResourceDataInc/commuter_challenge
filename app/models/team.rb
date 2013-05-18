class Team < ActiveRecord::Base
  default_scope order('name ASC')
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

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def approved_users
    memberships.where(approved: true)
  end

  def participation_percent
    @participation_percent ||= 100.0 * actual_rides / possible_rides
  end

  private
  def actual_rides
    # here be dragons
    user_rides = rides.group_by(&:rider_id)
    user_rides.inject(0) do |total, (_, rides)|
      dated_rides = rides.group_by(&:date)
      total + dated_rides.inject(0) do |total, (_, rides)|
        total + [2, rides.inject(0) {|total, r| total + (r.is_round_trip ? 2 : 1)}].min
      end
    end
  end

  def possible_rides
    2 * business_size * competition.work_days
  end
end
