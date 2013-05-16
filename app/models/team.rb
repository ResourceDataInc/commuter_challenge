class Team < ActiveRecord::Base
  default_scope order('name ASC')
  belongs_to :captain, class_name: "User"
  has_many :memberships, inverse_of: :team, :dependent => :destroy
  has_many :members, through: :memberships, source: :user
  has_many :competitors, inverse_of: :team, :dependent => :destroy
  has_many :competitions, through: :competitors

  validates :name, presence: true
  validates :captain, presence: true
  validates :business_size, presence: true, :numericality => { :greater_than => 0 }

  attr_accessible :captain_id, :description, :name, :business_size

  def available_competitions
    Competition.joinable_by_team(self)
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
