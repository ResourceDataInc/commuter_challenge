require "spec_helper"

describe "teams" do
  let(:user) { FactoryGirl.create(:user) }

  it "can be created by a signed in user" do
    login_as user

    visit root_url
    click_on "Teams"
    click_on "Create Team"
    fill_in "team_name", with: "RDI Riders"
    fill_in "team_description", with: "Resource Data Inc"
    fill_in "team_business_size", with: 5
    click_on "Create Team"

    within(".alert") { page.should have_content "Team created" }
    within ".team" do
      page.should have_content "RDI Riders"
      page.should have_content "Resource Data Inc"
      page.should have_content 5
      page.should have_content user.username
    end
  end

  it "can be edited by a captain" do
    login_as user

    team = FactoryGirl.create(:team, captain: user, name: "Foo", description: "bar", business_size: 10)
    visit root_url
    click_on "Teams"
    click_on team.name
    within(".team") { click_on "Edit" }

    fill_in "team_name", with: "RDI Riders"
    fill_in "team_description", with: "Resource Data Inc"
    fill_in "team_business_size", with: 5
    click_on "Update Team"

    within(".alert") { page.should have_content "Team updated" }
    within ".team" do
      page.should have_content "RDI Riders"
      page.should have_content "Resource Data Inc"
      page.should have_content 5
      page.should_not have_content "Foo"
      page.should_not have_content "bar"
      page.should_not have_content 10
    end
  end

  it "can be destroyed by a captain" do
    login_as user

    team = FactoryGirl.create(:team, captain: user, name: "Foo", description: "bar")
    visit root_url
    click_on "Teams"
    click_on team.name
    within(".team") { click_on "Delete" }

    page.should have_content "Are you sure"
    click_on "Delete"
    within(".alert") { page.should have_content "Team deleted" }
  end
end