require 'spec_helper'

describe User do
  describe "associations" do
    it { should have_many :memberships }
    it { should have_many :teams }
    it { should have_many :rides }
  end

  describe "validation" do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :username }
    it { should validate_uniqueness_of :username }
  end
end
