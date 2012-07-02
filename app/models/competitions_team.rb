class CompetitionsTeam < ActiveRecord::Base
  attr_accessible :competition_id, :team_id
  belongs_to :competition
  belongs_to :team
  
  scope :approved, where(:approved=>true)
  scope :unapproved, where(:approved=>false)
end