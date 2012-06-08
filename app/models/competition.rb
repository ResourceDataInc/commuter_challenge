class Competition < ActiveRecord::Base
  belongs_to :contact, class_name: "User", foreign_key: "user_id"
  has_many :business_sizes, :dependent => :destroy
  has_and_belongs_to_many :teams
  
  accepts_nested_attributes_for :business_sizes, :allow_destroy => true
  attr_accessible :description, :end_date, :name, :start_date, :contact, :user_id

  validates_presence_of :name, :description, :start_date, :end_date, :contact
  validates :name, :uniqueness => true
  validate :end_date_cannot_be_before_start_date

  private

  def end_date_cannot_be_before_start_date
    if end_date < start_date
      errors.add(:end_date, "cannot be before start date")
    end
  end
end
