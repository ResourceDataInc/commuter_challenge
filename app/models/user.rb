class User < ActiveRecord::Base
  has_many :created_competitions, class_name: "Competition"
  has_many :teams_to_captain, class_name: "Team"
  has_many :competitions, through: :teams
  has_many :rides
  has_and_belongs_to_many :teams

	rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  def member? team
    return teams.include? team
  end
  
  def joined? competition
    return competitions.include? competition
  end
  
  def has_unjoined_team? competition
    teams.any?{|t| !t.competitions.include? competition}
  end
end
