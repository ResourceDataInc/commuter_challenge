class Competition < ActiveRecord::Base
  attr_accessible :description, :end_on, :owner_id, :start_on, :title, :brackets_attributes

  belongs_to :owner, class_name: "User"
  has_many :brackets, :dependent => :destroy, inverse_of: :competition
  accepts_nested_attributes_for :brackets
  has_many :competitors, inverse_of: :competition, :dependent => :destroy
  has_many :teams, through: :competitors, inverse_of: :competition
  has_many :members, through: :teams
  has_many :rides, through: :members
  
  validates :title, presence: true
  validates :description, presence: true
  validates :owner, presence: true
  validates :start_on, presence: true
  validates :end_on, presence: true

  validate :validate_start_on_before_end_on
  validate :validate_start_on_not_in_past

  scope :by_start_date, -> { order 'start_on desc' }

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def total_work_days
    calculations.total_work_days
  end

  def work_days
    calculations.work_days
  end

  def calculations
    @calculations ||= Calculations.new(start_on, end_on)
  end

  def active?
    (start_on..end_on).cover? Calendar.today
  end

  private

  def validate_start_on_before_end_on
    return if start_on.blank? || end_on.blank?
    unless start_on < end_on
      errors.add :end_on, "cannot be before start date"
    end
  end

  def validate_start_on_not_in_past
    return if start_on.blank?
    if start_on_changed? && start_on < Calendar.today
      errors.add :start_on, "cannot be in the past"
    end
  end
end
