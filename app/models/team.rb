class Team < ActiveRecord::Base
  belongs_to :captain, class_name: "User"
  has_many :memberships, inverse_of: :team
  has_many :members, through: :memberships, source: :user

  validates :name, presence: true
  validates :captain, presence: true
  validates :business_size, presence: true, :numericality => { :greater_than => 0 }

  attr_accessible :captain_id, :description, :name, :business_size
end
