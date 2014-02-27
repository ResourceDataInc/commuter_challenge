class Competition < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  has_many :brackets, :dependent => :destroy, inverse_of: :competition
  accepts_nested_attributes_for :brackets
  has_many :competitors, inverse_of: :competition, :dependent => :destroy
  has_many :teams, through: :competitors
  has_many :memberships, through: :teams
  has_many :members, through: :teams
  has_many :rides, through: :members
  
  validates :title, presence: true
  validates :description, presence: true
  validates :owner, presence: true
  validates :start_on, presence: true
  validates :end_on, presence: true

  validate :validate_start_on_before_end_on

  scope :by_start_date, -> { order 'start_on desc' }

  scope :active, -> { where(["start_on <= ? and end_on >= ?", Calendar.today, Calendar.today]) }

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def active?
    date_range.cover? Calendar.today
  end

  def date_range
    start_on..end_on
  end

  private

  def validate_start_on_before_end_on
    return if start_on.blank? || end_on.blank?
    unless start_on < end_on
      errors.add :end_on, "cannot be before start date"
    end
  end
end
