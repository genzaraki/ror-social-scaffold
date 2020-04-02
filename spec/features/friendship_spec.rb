require 'rails_helper'

RSpec.feature "Friendships", type: :feature do
  let(:user1) { User.create(name: 'JohnDoe', email: 'johndoe@ymail.com', password: 'password') }
  let(:user2) { User.create(name: 'JaneDoe', email: 'janedoe@ymail.com', password: 'password') }

  context 'Send a friend request' do
    before do
      visit new_user_session_path
      fill_in 'Email', with: user1.email
      fill_in 'Password', with: user1.password
      click_button 'Log in'
      expect(current_path).to eq root_path
      expect(page).to have_content(user1.name.to_s)
      expect(page).to have_content('Signed in successfully')
      visit users_path
      have_link user2.name , href: users_path(user2)
      visit users_path(user2)
    end

    it 'Sends a friend request to the user' do
      expect(page).to have_content(user1.name.to_s)
      expect(page).to have_content(user2.name.to_s)
      click_button 'add_friend'
    end


  end
end
