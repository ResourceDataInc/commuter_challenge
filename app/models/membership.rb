class Membership < ActiveRecord::Base
  belongs_to :team
  belongs_to :user

  attr_accessible :team_id, :user_id, :user, :approved

  before_save :update_approved_at

  private

  def update_approved_at
    if approved_changed? && approved?
      self.approved_at = Time.now
    end
  end
end
