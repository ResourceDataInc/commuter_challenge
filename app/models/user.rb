class User < ActiveRecord::Base
  default_scope order('username ASC')

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :username, :password, :password_confirmation,
                  :remember_me

  has_many :memberships, inverse_of: :user
  has_many :teams, through: :memberships

  validates :username, presence: true, uniqueness: true
end
