class Team < ActiveRecord::Base
  belongs_to :captain, class_name: "User", foreign_key: "user_id"
  has_and_belongs_to_many :competitions
  has_and_belongs_to_many :cyclists, class_name: "User", :association_foreign_key => "user_id",
      :join_table => "teams_users"
  
  attr_accessible :description, :name, :captain, :user_id
  
  validates :name, :uniqueness => true
end
