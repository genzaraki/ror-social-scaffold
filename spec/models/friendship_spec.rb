require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user1) { User.create(name: 'JohnDoe', email: 'johndoe@ymail.com', password: 'password') }
  let(:user2) { User.create(name: 'JaneDoe', email: 'janedoe@ymail.com', password: 'password') }
  let(:friendship) { Friendship.new(user_id: user1.id, friend_id: user2.id) }

  describe 'Validations' do
    it 'has to have a user_id' do
      expect(friendship.user_id).to eq(user1.id)
    end
    it 'has to have a friend_id' do
      expect(friendship.friend_id).to eq(user2.id)
    end
    it 'returns an error for missing user_id' do
      friendship.user_id = nil
      expect(friendship.save).to eq(false)
    end
    it 'returns an error for missing friend_id' do
      friendship.friend_id = nil
      expect(friendship.save).to eq(false)
    end
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end
end
