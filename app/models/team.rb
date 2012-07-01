class Team < ActiveRecord::Base
  belongs_to :captain, class_name: "User", foreign_key: "user_id"
  has_and_belongs_to_many :competitions
  has_many :teams_users
  has_many :cyclists, :through => :teams_users, source: :user

  attr_accessible :description, :name, :captain, :user_id, :business_size, :cyclists

  validates :name, :uniqueness => true
  validates_presence_of :name, :business_size

  def self.in_range(lower, upper)
    where "business_size between ? and ?", lower, upper
  end
  
  def approved_team_users
    teams_users.approved
  end
  
  def not_approved_team_users
    teams_users.not_approved
  end
end
