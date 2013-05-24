require 'spec_helper'

describe Competition do
  context "associations" do
    it "should delete competitors when deleted" do
      competition = FactoryGirl.create(:competition)
      id = competition.id
      competition.competitors.create(team: FactoryGirl.create(:team))

      competition.destroy
      competitor = Competitor.find_by_competition_id(id)
      competitor.should be_nil
    end
  end

  context "validation" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :owner }
    it { should validate_presence_of :start_on }
    it { should validate_presence_of :end_on }

    it "should require end date be greater than start date" do
      competition = FactoryGirl.build :competition,
        start_on: 2.weeks.from_now,
        end_on: 1.day.from_now
      competition.should_not be_valid
      competition.should have(1).error_on(:end_on)

      competition.end_on = 1.month.from_now
      competition.should be_valid
    end

    it "should require start date be in the future" do
      competition = FactoryGirl.build :competition,
        start_on: 1.month.ago
      competition.should_not be_valid
      competition.should have(1).error_on(:start_on)

      competition.start_on = Time.now
      competition.should be_valid
    end
  end

  context "helpers" do
    it "should count the total number of weekdays in the competition" do
      competition = FactoryGirl.build(:competition,
        start_on: Date.new(2013, 02, 01),
        end_on: Date.new(2013, 02, 15))
      competition.total_work_days.should equal(11)
    end

    it "should count the weekdays in the competition so far" do
      Date.stub(today: Date.new(2013, 02, 05))
      competition = FactoryGirl.build(:competition,
        start_on: Date.new(2013, 02, 04),
        end_on: Date.new(2013, 02, 10))
      competition.work_days.should equal(2)

      competition.start_on = Date.new(2013, 02, 05)
      competition.end_on = Date.new(2013, 02, 05)
      competition.work_days.should equal(1)

      competition.start_on = Date.new(2013, 02, 07)
      competition.end_on = Date.new(2013, 02, 10)
      competition.work_days.should equal(0)
    end
  end
end
