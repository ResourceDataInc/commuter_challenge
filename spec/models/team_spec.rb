require 'spec_helper'

describe Team do
  context "associations" do
    it { should belong_to :captain }
  end

  context "validation" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :captain }
  end
end
