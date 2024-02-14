require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) {create(:user)}

  describe 'List user' do 
    before do
      visit users_path
    end

    describe '#index' do
      it 'displays name of the user' do 
        expect(page).to have_content user.name
      end

      it 'display a link to details screen' do
        expect(page).to have_link user.name, href: "/users/#{user.id}"
      end

      it 'display a button to create user' do
        expect(page).to have_link "New User", href: new_user_path
      end
    end
  end

  describe 'Details screen' do
    before do
      visit users_path(user)
    end

    describe '#show' do
      it 'displays name of the user' do
        expect(page).to have_content user.name
      end
    end
  end
end
