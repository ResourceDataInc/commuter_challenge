class Competition < ActiveRecord::Base
  belongs_to :contact, class_name: "User", foreign_key: "user_id"
  attr_accessible :description, :end_date, :name, :start_date, :contact
end
