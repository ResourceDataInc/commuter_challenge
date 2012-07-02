class Competition < ActiveRecord::Base
  belongs_to :contact, class_name: "User", foreign_key: "user_id"
  has_many :business_sizes, :dependent => :destroy
  
  has_many :competitions_teams
  has_many :teams, :through => :competitions_teams
  
  accepts_nested_attributes_for :business_sizes, :allow_destroy => true
  attr_accessible :description, :end_date, :name, :start_date, :contact, :user_id, :teams

  validates_presence_of :name, :description, :start_date, :end_date, :contact
  validates :name, :uniqueness => true
  validate :end_date_cannot_be_before_start_date
  
  def approved_competitions_teams
    competitions_teams.approved
  end
  
  def unapproved_competitions_teams
    competitions_teams.unapproved
  end

  private

  def end_date_cannot_be_before_start_date
    if end_date < start_date
      errors.add(:end_date, "cannot be before start date")
    end
  end
end
