require 'spec_helper'

describe Membership do
  describe "associations" do
    it { should belong_to :team }
    it { should belong_to :user }
  end

  describe "validations" do
    it { should validate_presence_of :team }
    it { should validate_presence_of :user }
    it { should validate_presence_of :ride_count }
    it do
      should validate_numericality_of(:ride_count)
        .is_greater_than_or_equal_to(0)
    end
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

  describe "approved scope" do
    it "includes approved memberships" do
      approved = FactoryGirl.create(:membership, approved: true)
      expect(Membership.approved).to include(approved)
    end

    it "does not include unapproved memberships" do
      unapproved = FactoryGirl.create(:membership, approved: false)
      expect(Membership.approved).to_not include(unapproved)
    end
  end
end
