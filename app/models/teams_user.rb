class TeamsUser < ActiveRecord::Base
  attr_accessible :team_id, :user_id, :approved
  belongs_to :team
  belongs_to :user
  
  scope :approved, where(:approved=>true)
  scope :not_approved, where(:approved=>false)
end