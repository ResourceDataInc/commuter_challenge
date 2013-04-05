class Competition < ActiveRecord::Base
  attr_accessible :description, :end_on, :owner_id, :start_on, :title

  belongs_to :owner, class_name: "User"

  validates :title, presence: true
  validates :description, presence: true
  validates :owner, presence: true
  validates :start_on, presence: true
  validates :end_on, presence: true

  validate :validate_start_on_before_end_on
  validate :validate_start_on_not_in_past

  private

  def validate_start_on_before_end_on
    return if start_on.blank? || end_on.blank?
    unless start_on < end_on
      errors.add :end_on, "cannot be before start date"
    end
  end

  def validate_start_on_not_in_past
    return if start_on.blank?
    if start_on_changed? && start_on < Date.today
      errors.add :start_on, "cannot be in the past"
    end
  end
end
