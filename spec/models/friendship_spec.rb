require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user1) { User.create(name: 'JohnDoe', email: 'johndoe@ymail.com', password: 'password') }
  let(:user2) { User.create(name: 'JaneDoe', email: 'janedoe@ymail.com', password: 'password') }
  let(:friendship) { Friendship.new(sender_id: user1.id, receiver_id: user2.id) }

  it 'has to have a sender_id' do
    expect(friendship.sender_id).to eq(user1.id)
  end
  it 'has to have a receiver_id' do
    expect(friendship.receiver_id).to eq(user2.id)
  end
  it 'returns an error for missing sender_id' do
    friendship.sender_id = nil
    expect(friendship.save).to eq(false)
  end
  it 'returns an error for missing receiver_id' do
    friendship.receiver_id = nil
    expect(friendship.save).to eq(false)
  end
end
