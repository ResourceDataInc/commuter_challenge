class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :username, :password, :password_confirmation,
                  :remember_me

  has_many :memberships, inverse_of: :user, :dependent => :destroy
  has_many :teams, through: :memberships
  has_many :rides, foreign_key: :rider_id, :dependent => :destroy

  validates :username, presence: true, uniqueness: true

  def total_distance
    rides.map(&:total_distance).sum
  end

  def to_param
    "#{id}-#{username.parameterize}"
  end
  
  # calculates the amount of rides - round trips count as 2, one way and null as one
  def ride_count
  	return (self.rides.where("is_round_trip").count * 2) + 
  		self.rides.where("is_round_trip IN (FALSE,NULL)").count
  end
  
end
