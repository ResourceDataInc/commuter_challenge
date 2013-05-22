class Bracket < ActiveRecord::Base
  default_scope order('lower_limit ASC')
  belongs_to :competition
  
  validates :name, presence: true
  validates :lower_limit, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :upper_limit, presence: true
  validates :competition, presence: true
  validate :validate_upper_limit_after_lower_limit
  validate :validate_upper_limit_cannot_be_between_existing_boundary
  validate :validate_lower_limit_cannot_be_between_existing_boundary

  attr_accessible :competition_id, :lower_limit, :name, :upper_limit

  def teams
    competition.teams.where("business_size between ? AND ?", lower_limit, upper_limit)
  end

  def teams_by_participation
    teams.sort_by(&:participation_percent)
  end

  private

  def validate_upper_limit_after_lower_limit
    return if lower_limit.blank? || upper_limit.blank?    
    unless lower_limit < upper_limit
      errors.add :upper_limit, "cannot be before lower limit"
    end
  end

  def validate_upper_limit_cannot_be_between_existing_boundary
    return if lower_limit.blank? || upper_limit.blank?
    if limit_between_existing_boundaries competition_id, upper_limit
      errors.add(:upper_limit, "cannot overlap an existing boundary")
    end
  end

  def validate_lower_limit_cannot_be_between_existing_boundary
    return if lower_limit.blank? || upper_limit.blank?
    if limit_between_existing_boundaries competition_id, lower_limit
      errors.add(:lower_limit, "cannot overlap an existing boundary")
    end
  end

  def limit_between_existing_boundaries competition_id, limit
    return Bracket.where("competition_id = ? AND ? between lower_limit AND upper_limit", competition_id, limit).exists?
  end
end
