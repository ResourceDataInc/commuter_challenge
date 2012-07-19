class Ride < ActiveRecord::Base
  belongs_to :user
  attr_accessible :date, :distance, :name, :user
  validates :distance, :format => { :with => /^\s*-?(\d+(\.\d{1,2})?|\.\d{1,2})\s*$/, 
    :message => "is more than 2 decimal places"},  :numericality => {:greater_than_or_equal_to => 0.01, :less_than => 100}
  
  validates_presence_of :distance, :date
end
