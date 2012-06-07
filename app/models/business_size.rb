class BusinessSize < ActiveRecord::Base
  belongs_to :competition 
  attr_accessible :competition_id, :lower_bound, :name, :upper_bound
  
  validates_presence_of :name, :lower_bound
  validates :name, :uniqueness => {:scope => :competition_id}
  validate :upper_bound_cannot_be_before_lower_bound
  validate :upper_bound_cannot_be_between_existing_boundary
  validate :lower_bound_cannot_be_between_existing_boundary
  
  private

  def upper_bound_cannot_be_before_lower_bound
    if upper_bound && upper_bound < lower_bound
      errors.add(:upper_bound, "cannot be before lower bound")
    end
  end
  
  def upper_bound_cannot_be_between_existing_boundary
    if bound_between_existing_boundaries competition_id, upper_bound
      errors.add(:upper_bound, "cannot overlap an existing boundary")
    end
    
  end
  
  def lower_bound_cannot_be_between_existing_boundary
    if(bound_between_existing_boundaries competition_id, lower_bound)
      errors.add(:lower_bound, "cannot overlap an existing boundary")
    end
  end
  
  def bound_between_existing_boundaries competition_id, bound
    if(bound.nil?)
      return false
    else
      return BusinessSize.where("competition_id = ? AND upper_bound NOT NULL AND lower_bound <= ? AND upper_bound >= ?", competition_id, bound, bound).count > 0
    end
  end
end
