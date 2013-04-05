class Competition < ActiveRecord::Base
  attr_accessible :description, :end_on, :owner_id, :start_on, :title

  belongs_to :owner, class_name: "User"

  validates :title, presence: true
  validates :description, presence: true
  validates :owner, presence: true
  validates :start_on, presence: true
  validates :end_on, presence: true
end
