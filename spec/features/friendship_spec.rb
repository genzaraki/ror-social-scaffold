require 'rails_helper'

RSpec.feature 'Friendships', type: :feature do
  let(:user1) { User.create(name: 'JohnDoe', email: 'johndoe@ymail.com', password: 'password') }
  let(:user2) { User.create(name: 'JaneDoe', email: 'janedoe@ymail.com', password: 'password') }

  context 'Send and cancel a friend request' do
    before do
      visit new_user_session_path
      fill_in 'Email', with: user1.email
      fill_in 'Password', with: user1.password
      click_button 'Log in'
      expect(current_path).to eq root_path
      expect(page).to have_content(user1.name.to_s)
      expect(page).to have_content('Signed in successfully')
      visit users_path
      have_link user2.name, href: users_path(user2)
      visit users_path(user2)
    end

    it 'Sends a friend request to the user' do
      expect(page).to have_content(user1.name.to_s)
      expect(page).to have_content(user2.name.to_s)
      click_button 'add_friend'
      expect(current_path).to eq user_friendships_sent_path(user1)
      expect(page).to have_content(user2.name.to_s)
    end

    it 'Cancels a friend request ' do
      expect(page).to have_content(user1.name.to_s)
      expect(page).to have_content(user2.name.to_s)
      click_button 'add_friend'
      expect(current_path).to eq user_friendships_sent_path(user1)
      expect(page).to have_content(user2.name.to_s)
      click_button 'cancel_friend'
      expect(current_path).to eq user_friendships_sent_path(user1)
      expect(page).to have_content('You have no friend requests sent for now.')
    end
  end
  context 'Respond to a friend request' do
    before do
      visit new_user_session_path
      fill_in 'Email', with: user1.email
      fill_in 'Password', with: user1.password
      click_button 'Log in'
      expect(current_path).to eq root_path
      expect(page).to have_content(user1.name.to_s)
      expect(page).to have_content('Signed in successfully')
      visit users_path
      have_link user2.name, href: users_path(user2)
      visit users_path(user2)
      click_button 'add_friend'
      expect(page).to have_content('Friend Request send!.')
      click_on 'Sign out'
      expect(current_path).to eq(new_user_session_path)
      fill_in 'Email', with: user2.email
      fill_in 'Password', with: user2.password
      click_button 'Log in'
      expect(current_path).to eq root_path
      expect(page).to have_content(user2.name.to_s)
      expect(page).to have_content('Signed in successfully')
      visit user_friendships_received_path(user2)
    end

    it 'Accepts  friend request' do
      click_button 'accept_friend'
      expect(current_path).to eq user_friendships_path(user2)
      expect(page).to have_content(user2.name.to_s)
      have_link user1.name, href: users_path(user1)
    end
    it 'Rejects  friend request' do
      click_button 'reject_friend'
      expect(current_path).to eq user_friendships_received_path(user2)
      expect(page).to have_content('You have no friend requests for now.')
    end
    it 'Deletes a friend ' do
      click_button 'accept_friend'
      expect(current_path).to eq user_friendships_path(user2)
      expect(page).to have_content(user2.name.to_s)
      have_link user1.name, href: users_path(user1)
      click_button 'delete_friend'
      expect(current_path).to eq user_friendships_path(user2)
      expect(page).to have_content('You have no friend for now.')
    end
  end
end
