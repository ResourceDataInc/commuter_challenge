class Team < ActiveRecord::Base
  belongs_to :captain, class_name: "User"
  has_many :memberships, inverse_of: :team, :dependent => :destroy
  has_many :members, through: :memberships, source: :user
  has_many :rides, through: :members
  has_one :competitor, inverse_of: :team, :dependent => :destroy
  has_one :competition, through: :competitor

  validates :name, presence: true
  validates :captain, presence: true
  validates :business_size, presence: true, :numericality => { :greater_than => 0 }
  validate :business_size_cannot_be_lower_than_approved_memberships, on: :update

  scope :by_name, -> { order :name }

  def to_param
    "#{id}-#{name.parameterize}"
  end

  private

  def business_size_cannot_be_lower_than_approved_memberships
    if self.business_size < self.memberships.approved.count
      errors.add(:business_size, "Cannot be lower than approved membership.")
    end
  end

end
