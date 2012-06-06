class Competition < ActiveRecord::Base
  belongs_to :contact, class_name: "User", foreign_key: "user_id"
  attr_accessible :description, :end_date, :name, :start_date, :contact

  validates_presence_of :name, :description, :start_date, :end_date, :contact
  validate :end_date_cannot_be_before_start_date

  private

  def end_date_cannot_be_before_start_date
    if end_date < start_date
      errors.add(:end_date, "cannot be before start date")
    end
  end
end
