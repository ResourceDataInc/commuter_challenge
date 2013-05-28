require "spec_helper"

describe "memberships" do
  let(:competition) { FactoryGirl.create(:competition) }
  let(:captain) { FactoryGirl.create(:user) }
  let(:user) { FactoryGirl.create(:user) }
  let(:team) { FactoryGirl.create(:team, captain: captain) }
  let!(:competitior) { FactoryGirl.create(:competitor, competition_id: competition.id, team_id: team.id)}

  it "can request to join" do
    login_as user
    visit team_url(team)
    click_on I18n.t("team.join.action")
    within ".alert" do
      page.should have_content I18n.t("team.join.request_confirmation")
    end
    page.should_not have_link I18n.t("team.join.action")
  end

  it "can be approved by a captain" do
    membership = FactoryGirl.create(:membership, team: team, user: user, approved: false)
    login_as captain
    visit team_url(team)

    within selector_for(membership) do
      click_on I18n.t("team.join.approve_action")
    end

    within(".alert") do
      page.should have_content I18n.t("team.join.approve_confirmation")
    end

    within selector_for(membership) do
      page.should_not have_button I18n.t("team.join.approve_action")
      page.should_not have_link I18n.t("team.join.approve_action")
    end
  end

  it "cannot be approved by member" do
    membership = FactoryGirl.create(:membership, team: team, user: user, approved: false)
    login_as user
    visit team_url(team)
    within selector_for(membership) do
      page.should_not have_button I18n.t("team.join.approve_action")
      page.should_not have_link I18n.t("team.join.approve_action")
    end
  end

  it "can be deleted by captain" do
    membership = FactoryGirl.create(:membership, team: team, approved: true)
    login_as captain
    visit team_url(team)
    within selector_for(membership) do
      click_on I18n.t("membership.delete.action")
    end

    page.should have_content "Are you sure"
    click_on I18n.t("membership.delete.action")
    within(".alert") do
      page.should have_content I18n.t("membership.delete.success")
    end
  end
end
