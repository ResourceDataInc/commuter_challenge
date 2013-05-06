require "spec_helper"

describe "rides" do
  let(:user) { FactoryGirl.create(:user) }

  it "can be created by a signed in user" do
    login_as user

    visit root_url
    click_on "Rides"
    click_on I18n.t("ride.add.action")
    fill_in "ride_date", with: 1.day.ago.strftime("%Y-%m-%d")
    fill_in "ride_description", with: "To Work"
    fill_in "ride_distance", with: 2.5
    choose('ride_is_round_trip_false')

    click_on I18n.t("ride.submit")

    within(".alert") { page.should have_content I18n.t("ride.add.success")}
    within ".ride" do
      page.should have_content "To Work"
      page.should have_content 2.5
      page.should have_content user.username
      page.should have_content 1.day.ago.strftime("%Y-%m-%d")
    end
  end

  it "can be edited by owner" do
    ride = FactoryGirl.create :ride, rider: user
    login_as user
    visit ride_url(ride)
    within(".ride") { click_on I18n.t("ride.edit.action") }

    fill_in "ride_date", with: 1.day.ago.strftime("%Y-%m-%d")
    fill_in "ride_description", with: "To Work"
    fill_in "ride_distance", with: 2.5
    choose('ride_is_round_trip_false')
    click_button I18n.t("ride.submit")

    within(".alert") { page.should have_content I18n.t("ride.edit.success") }
    within ".ride" do
      page.should have_content "To Work"
      page.should have_content 2.5
      page.should have_content user.username
      page.should have_content 1.day.ago.strftime("%Y-%m-%d")
    end
  end

  it "can be deleted by owner" do
    ride = FactoryGirl.create :ride, rider: user
    login_as user
    visit ride_url(ride)
    click_on I18n.t("ride.delete.action")
    page.should have_content "Are you sure"
    click_on I18n.t("ride.delete.action")
    within(".alert") { page.should have_content I18n.t("ride.delete.success") }
  end

  it "cannot be created by anonymous user" do
    visit rides_url
    page.should_not have_link I18n.t("ride.add.action")
  end
end