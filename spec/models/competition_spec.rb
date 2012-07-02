require 'spec_helper'

describe Competition do
  context "validations" do
    it "should not allow start date after end date" do
      subject.start_date = 1.week.from_now
      subject.end_date = 1.week.ago
      subject.should have(1).error_on(:end_date)
    end
    
    it "should set approved status to false when a team joins" do      
      team = Team.new :name => 'asdfasdfasdfasdf', :business_size => 10
      subject.teams << team
      subject.name = 'test'
      subject.description = 'test'
      subject.contact = User.new email: "bob@example.com", password: "pwd4bob", password_confirmation: "pwd4bob"
      subject.start_date = 1.week.ago
      subject.end_date = 1.week.from_now
      subject.save
      subject.competitions_teams.first.approved.should be_false
    end
  end
end
