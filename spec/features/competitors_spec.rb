require "spec_helper"

describe "competitors" do  
  let(:owner) { FactoryGirl.create(:user) }
  let!(:competition) { FactoryGirl.create(:competition, owner: owner)}
  let(:captain) { FactoryGirl.create(:user) }
  let(:user) { FactoryGirl.create(:user) }
  let(:team) { FactoryGirl.create(:team, captain: captain) }

  it "can be approved by a competition owner" do
    competitor = FactoryGirl.create(:competitor, competition: competition, team: team, approved: false)
    login_as owner
    visit edit_competition_url(competition)

    within selector_for(competitor) do
      click_on I18n.t("competition.join.approve_action")
    end
    within(".alert") do
      page.should have_content I18n.t("competition.join.approve_confirmation")
    end
    within selector_for(competitor) do
      page.should_not have_button I18n.t("competition.join.approve_action")
      page.should_not have_link I18n.t("competition.join.approve_action")
    end
  end

  it "cannot be approved by captain" do
    competitor = FactoryGirl.create(:competitor, competition: competition, team: team, approved: false)
    login_as captain
    visit edit_competition_url(competition)
    page.should have_content"You are not authorized to access this page"
  end
end
