class Team < ActiveRecord::Base
  belongs_to :captain, class_name: "User", foreign_key: "user_id"
  has_and_belongs_to_many :competitions
  
  attr_accessible :description, :name, :captain, :user_id
  
  validates :name, :uniqueness => true
end
