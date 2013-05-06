class Competitor < ActiveRecord::Base
  belongs_to :competition
  belongs_to :team

  validates :competition, presence: true
  validates :team, presence: true

  attr_accessible :approved, :approved_at

  before_save :update_approved_at

  private

  def update_approved_at
    if approved_changed? && approved?
      self.approved_at = Time.now
    end
  end
end
