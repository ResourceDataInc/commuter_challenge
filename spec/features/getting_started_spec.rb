require "spec_helper"

describe "Getting started" do
  it "includes a countdown of days left in the competition" do
    FactoryGirl.create(:competition,
                       start_on: 1.month.ago,
                       end_on: 17.days.from_now)

    visit help_path

    # today + 17 more
    page.should have_content "18 Days Left"
  end

  it "notes the competition is over" do
    FactoryGirl.create(:competition,
                       start_on: 4.months.ago,
                       end_on: 1.month.ago)

    visit help_path
    page.should have_content I18n.t("help.competition.ended")
  end
end
