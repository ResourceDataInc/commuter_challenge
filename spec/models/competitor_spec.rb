require 'spec_helper'

describe Competitor do
  context "associations" do
    it { should belong_to :competition }
    it { should belong_to :team }
  end

  context "validations" do
    it { should validate_presence_of :competition }
    it { should validate_presence_of :team }
    it { should validate_uniqueness_of :team_id }
  end

  describe "approval" do
    it "sets approved_at" do
      competitor = FactoryGirl.create(:competitor, approved: false)
      time = Time.parse("1955-11-05")
      Time.stub(now: time)
      competitor.approved = true
      competitor.save
      competitor.approved_at.should == time
    end
  end
end
