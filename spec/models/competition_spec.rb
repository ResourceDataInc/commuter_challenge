require 'spec_helper'

describe Competition do
  context "validation" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :owner }
    it { should validate_presence_of :start_on }
    it { should validate_presence_of :end_on }
  end
end
