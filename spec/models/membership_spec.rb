require 'spec_helper'

describe Membership do
  describe "associations" do
    it { should belong_to :team }
    it { should belong_to :user }
  end
end
