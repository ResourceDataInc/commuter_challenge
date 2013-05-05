require "spec_helper"

describe "memberships" do
  let(:captain) { FactoryGirl.create(:user) }
  let(:user) { FactoryGirl.create(:user) }
  let(:team) { FactoryGirl.create(:team, captain: captain) }

  it "can request to join" do
    login_as user
    visit team_url(team)
    click_on I18n.t("team.join.action")
    within ".alert" do
      page.should have_content I18n.t("team.join.request_confirmation")
    end
    page.should_not have_link I18n.t("team.join.action")
  end
end
