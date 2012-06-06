require 'spec_helper'

describe Competition do
  context "validations" do
    it "should not allow start date after end date" do
      subject.start_date = 1.week.from_now
      subject.end_date = 1.week.ago
      subject.should have(1).error_on(:end_date)
    end
  end
end
