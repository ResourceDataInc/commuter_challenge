class Membership < ActiveRecord::Base
  belongs_to :team, inverse_of: :memberships
  belongs_to :user, inverse_of: :memberships

  validates :team, associated: true, presence: true
  validates :user, associated: true, presence: true

  attr_accessible :team_id, :team, :user_id, :user, :approved

  before_save :update_approved_at

  private

  def update_approved_at
    if approved_changed? && approved?
      self.approved_at = Time.now
    end
  end
end
