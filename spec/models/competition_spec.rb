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
  end

  context "status" do
    it "is active if current date is between start and end date" do
      Calendar.stub today: Time.zone.parse("2013-08-19").to_date
      competition = FactoryGirl.build(:competition,
        start_on: Date.new(2013, 7, 01),
        end_on: Date.new(2013, 8, 31))
      competition.should be_active
    end

    it "is not active if current date is before start date" do
      Calendar.stub today: Time.zone.parse("2013-07-19").to_date
      competition = FactoryGirl.build(:competition,
        start_on: Date.new(2013, 8, 01),
        end_on: Date.new(2013, 8, 31))
      competition.should_not be_active
    end

    it "is not active if current date is after end date" do
      Calendar.stub today: Time.zone.parse("2013-09-19").to_date
      competition = FactoryGirl.build(:competition,
        start_on: Date.new(2013, 8, 01),
        end_on: Date.new(2013, 8, 31))
      competition.should_not be_active
    end
  end

  describe "active scope" do
    it "includes competitions whose end date has not passed" do
      competition = FactoryGirl.create(:competition, start_on: 1.month.ago, end_on: 1.month.from_now)
      expect(Competition.active).to include(competition)
    end

    it "includes competitions that start today" do
      competition = FactoryGirl.create(:competition, start_on: Date.today, end_on: 4.months.from_now)
      expect(Competition.active).to include(competition)
    end

    it "includes competitions that end today" do
      competition = FactoryGirl.create(:competition, start_on: 1.month.ago, end_on: Date.today)
      expect(Competition.active).to include(competition)
    end

    it "does not include competitions whose end date has passed" do
      competition = FactoryGirl.create(:competition, start_on: 1.month.ago, end_on: 1.week.ago)
      expect(Competition.active).to_not include(competition)
    end

    it "does not include future competitions" do
      competition = FactoryGirl.create(:competition, start_on: 1.month.from_now, end_on: 4.months.from_now)
      expect(Competition.active).to_not include(competition)
    end
  end
end
