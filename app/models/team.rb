class Team < ActiveRecord::Base
  belongs_to :captain, class_name: "User"
  has_many :memberships
  has_many :members, through: :memberships, source: :user

  validates :name, presence: true
  validates :captain, presence: true

  attr_accessible :captain_id, :description, :name
end
