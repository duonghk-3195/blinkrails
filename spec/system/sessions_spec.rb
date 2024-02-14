require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  # let!(:user) {create(:user)}

  describe "check login" do
    before do
      visit login_path
    end

    describe "#new" do 
      it "display screen name" do 
        expect(page).to have_content "Log in"
      end

      it "display forgot password link" do
        expect(page).to have_link '(forgot password)', href: new_password_reset_path
      end

      it "display login button" do
        expect(page).to have_button "Log in"
      end
    end

    describe "#create" do
      it "test log in success" do
        fill_in 'session[email]', with: 'ho.khanh.duong99@gmail.com'
        fill_in 'session[password]', with: '123456'
        click_button 'Log in'
        expect(page).to have_http_status(200)
      end

      it "test login incorrect" do
        fill_in 'session[email]', with: 'example12.email@gmail.com'
        fill_in 'session[password]', with: '1234563495309458'
        click_button 'Log in'
        # expect(page).to have_content "Email or password is incorrect"
        expect(page).to have_http_status(4000)
      end
    end
  end
  
end
