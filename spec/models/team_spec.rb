require 'spec_helper'

describe Team do
  context "associations" do
    it { should belong_to :captain }
    it { should have_many :memberships }
    it { should have_many :members }
  end

  context "validation" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :captain }
  end
end
