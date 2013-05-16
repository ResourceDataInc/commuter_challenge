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
end
