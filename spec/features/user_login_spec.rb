require 'spec_helper'

describe "User Login" do
  describe "Home" do
    context "user should be able to see a login link" do
      it "has a link to the user login page" do
        visit root_path
        expect(page).to have_content "Log In"
        expect(page).to have_selector "a"
      end
    end
  end
end