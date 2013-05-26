require "spec_helper"

describe "competitions" do
  let(:user) { FactoryGirl.create(:user) }

  it "can not be created by signed in user" do
    login_as user
    visit competitions_url

    page.should_not have_link I18n.t("competition.add.action")
  end

  it "can be edited by owner" do
    competition = FactoryGirl.create :competition, owner: user
    login_as user
    visit competition_url(competition)
    within(".competition") { click_on I18n.t("competition.edit.action") }

    fill_in "competition_title", with: "Lol Comp"
    fill_in "competition_description", with: "lolwut"
    fill_in "competition_start_on", with: 1.years.from_now.strftime("%Y-%m-%d")
    fill_in "competition_end_on", with: 23.years.from_now.strftime("%Y-%m-%d")
    click_button "Update Competition"

    within(".alert") { page.should have_content I18n.t("competition.edit.success") }
    within ".competition" do
      page.should have_content "Lol Comp"
    end
  end

  it "can be deleted by owner" do
    competition = FactoryGirl.create :competition, owner: user
    login_as user
    visit competition_url(competition)
    click_on I18n.t("competition.delete.action")
    page.should have_content "Are you sure"
    click_on I18n.t("competition.delete.action")
    page.should have_content I18n.t("competition.delete.success")
  end

  it "cannot be created by anonymous user" do
    visit competitions_url
    page.should_not have_link I18n.t("competition.add.action")
  end
end
