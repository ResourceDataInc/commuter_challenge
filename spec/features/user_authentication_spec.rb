require "spec_helper"

describe "a user" do
  let(:user) { FactoryGirl.create :user, username: "Test User" }

  context "not signed in" do
    before(:each) { visit root_url }

    it "can sign up for an account" do
      click_on "Sign up"
      fill_in "user_email", with: "test@example.com"
      fill_in "user_username", with: "Test User"
      fill_in "user_password", with: "pwd4test"
      fill_in "user_password_confirmation", with: "pwd4test"
      click_button "Sign up"

      page.should have_content "test@example.com"
      page.should have_link "Sign out"
      page.should_not have_link "Sign up"
      page.should_not have_link "Sign in"
    end

    it "can sign in" do
      FactoryGirl.create :user,
        email: "test@example.com",
        username: "Test User",
        password: "pwd4test"

      click_on "Sign in"
      fill_in "user_email", with: "test@example.com"
      fill_in "user_password", with: "pwd4test"
      click_button "Sign in"
      page.should have_content "test@example.com"
      page.should have_link "Sign out"
      page.should_not have_link "Sign in"
      page.should_not have_link "Sign up"
    end
  end

  context "signed in" do
    before(:each) do
      login_as user
      visit root_url
    end

    it "can sign out" do
      click_on "Sign out"
      page.should_not have_content "Test User"
      page.should_not have_link "Sign out"
      page.should have_link "Sign up"
      page.should have_link "Sign in"
    end

    it "can edit account info" do
      within "#session" do
        click_on I18n.t("user.edit.action")
      end
      fill_in "user_email", with: "changed@example.com"
      fill_in "user_username", with: "Changed User"
      fill_in "user_current_password", with: "pwd4test"
      click_on "Update"
      page.should have_content "changed@example.com"
    end
  end
end
