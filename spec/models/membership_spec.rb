require 'spec_helper'

describe Membership do
  describe "associations" do
    it { should belong_to :team }
    it { should belong_to :user }
  end

  describe "validations" do
    it { should validate_presence_of :team }
    it { should validate_presence_of :user }
  end

  describe "approval" do
    it "sets approved_at" do
      time = Time.parse("1955-11-05")
      Time.stub(now: time)
      membership = FactoryGirl.create(:membership, approved: false)
      membership.approved = true
      membership.save
      membership.approved_at.should == time
    end
  end
end
