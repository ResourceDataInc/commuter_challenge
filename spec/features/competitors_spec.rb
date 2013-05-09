require "spec_helper"

describe "competitors" do  
  let(:owner) { FactoryGirl.create(:user) }
  let!(:competition) { FactoryGirl.create(:competition, owner: owner)}
  let(:captain) { FactoryGirl.create(:user) }
  let(:user) { FactoryGirl.create(:user) }
  let(:team) { FactoryGirl.create(:team, captain: captain) }

  it "can request to join" do
    login_as captain
    visit team_url(team)
    within selector_for(competition) do
      click_on I18n.t("competition.join.action")
    end
    within ".alert" do
      page.should have_content I18n.t("competition.join.request_confirmation")
    end
    page.should_not have_link I18n.t("competition.join.action")
  end

  it "can be approved by a competition owner" do
    competitor = FactoryGirl.create(:competitor, competition: competition, team: team, approved: false)
    login_as owner
    visit competition_url(competition)

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
    visit competition_url(competition)
    within selector_for(competitor) do
      page.should_not have_button I18n.t("competition.join.approve_action")
      page.should_not have_link I18n.t("competition.join.approve_action")
    end
  end

  it "can be deleted by captain" do
    competitor = FactoryGirl.create(:competitor, team: team, approved: true)
    login_as captain
    visit team_url(team)
    within selector_for(competitor) do
      click_on I18n.t("competitor.delete.action")
    end

    page.should have_content "Are you sure"
    click_on I18n.t("competitor.delete.action")
    within(".alert") do
      page.should have_content I18n.t("competitor.delete.success")
    end
  end

  it "can be deleted by owner" do
    competitor = FactoryGirl.create(:competitor, competition: competition, team: team, approved: true)
    login_as owner
    visit team_url(team)
    within selector_for(competitor) do
      click_on I18n.t("competitor.delete.action")
    end

    page.should have_content "Are you sure"
    click_on I18n.t("competitor.delete.action")
    within(".alert") do
      page.should have_content I18n.t("competitor.delete.success")
    end
  end

  it "cannot be deleted by user" do
    competitor = FactoryGirl.create(:competitor, team: team, approved: true)
    team.memberships.create(user: user, approved: true)
    login_as user
    visit team_url(team)
    within selector_for(competitor) do
      page.should_not have_link I18n.t("competitor.delete.action")
    end
  end
end