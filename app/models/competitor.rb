class Competitor < ActiveRecord::Base
  belongs_to :competition, inverse_of: :competitors, :counter_cache => true
  belongs_to :team, inverse_of: :competitor

  validates :competition, associated: true, presence: true
  validates :team, associated: true, presence: true
  validates :team_id, uniqueness: true

  attr_accessible :approved, :approved_at, :team_id, :team

  before_save :update_approved_at

  private

  def update_approved_at
    if approved_changed? && approved?
      self.approved_at = Time.now
    end
  end
end
