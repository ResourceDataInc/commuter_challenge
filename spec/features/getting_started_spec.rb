require "spec_helper"

describe "Getting started" do
  it "includes a countdown of days left in the competition" do
    Calendar.stub today: Date.new(2013, 7, 15) # hack to bypass validation
    FactoryGirl.create(:competition,
                       start_on: Date.new(2013, 8, 1),
                       end_on: Date.new(2013, 8, 31))
    Calendar.stub today: Date.new(2013, 8, 15)

    visit help_path
    page.should have_content "17 Days Left"
  end

  it "notes the competition is over" do
    Calendar.stub today: Date.new(2013, 7, 15) # hack to bypass validation
    FactoryGirl.create(:competition,
                       start_on: Date.new(2013, 8, 1),
                       end_on: Date.new(2013, 8, 31))
    Calendar.stub today: Date.new(2013, 9, 15)

    visit help_path
    page.should have_content I18n.t("help.competition_ended")
  end
end
