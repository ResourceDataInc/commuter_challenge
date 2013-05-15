require "spec_helper"

describe "user" do
  context "show page" do
    it "should only include user's logged rides" do
      us = FactoryGirl.create(:user)
      our_ride = FactoryGirl.create(:ride, rider: us, description: "Jaunt")

      their_ride = FactoryGirl.create(:ride, description: "Trek")

      visit user_path(us)

      page.should have_selector selector_for(our_ride)
      page.should have_content "Jaunt"
      page.should_not have_selector selector_for(their_ride)
    end
  end
end
