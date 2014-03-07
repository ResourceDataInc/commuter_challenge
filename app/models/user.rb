class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships, inverse_of: :user, :dependent => :destroy
  has_many :teams, through: :memberships
  has_many :rides, foreign_key: :rider_id, :dependent => :destroy

  validates :username, presence: true, uniqueness: true

  def to_param
    "#{id}-#{username.parameterize}"
  end

  def active_membership
    # joining to a has-many-through association returns readonly records
    memberships.joins(:competition).merge(Competition.active).readonly(false).first
  end
end
