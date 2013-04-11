class Team < ActiveRecord::Base
  belongs_to :captain, class_name: "User"

  validates :name, presence: true
  validates :captain, presence: true

  attr_accessible :captain_id, :description, :name
end
