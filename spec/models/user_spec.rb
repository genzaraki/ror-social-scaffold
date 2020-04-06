require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: 'JohnDoe', email: 'johndoe@ymail.com', password: 'password') }
  let(:user2) { User.create(name: 'Tigana', email: 'tigana@ymail.com', password: 'password') }
  let(:friend) { User.create(name: 'JaneDoe', email: 'janedoe@ymail.com', password: 'password') }

  describe 'Validations' do
    context 'has name, email and password' do
      it 'is valid with a name' do
        expect(user.name).to eq('JohnDoe')
      end

      it 'is valid with an email' do
        expect(user.email).to eq('johndoe@ymail.com')
      end

      it 'is valid with  a password' do
        expect(user.password).to eq('password')
      end
    end

    context 'has to return an error for missing fields' do
      it 'is not valid without a name' do
        user.name = nil
        expect(user.save).to eq(false)
      end

      it 'is not valid without an email' do
        user.email = nil
        expect(user.save).to eq(false)
      end

      it 'is not valid without a password' do
        user.password = nil
        expect(user.save).to eq(false)
      end
    end
  end

  describe 'Methods' do
    it 'is valid with friend_requests include friend' do
      Friendship.create(user_id: user2.id, friend_id: friend.id)
      expect(friend.friend_requests).to include(user2)
    end

    it 'is valid with a send_friend_request working' do
      user2.send_friend_request(friend)
      expect(friend.friend_requests).to include(user2)
    end

    it 'is valid with confirm_friend working' do
      user2.send_friend_request(friend)
      friend.confirm_friend(user2)
      expect(friend.friends).to include(user2)
    end

    it 'is valid with reject_friend working' do
      user2.send_friend_request(friend)
      friend.reject_friend(user2)
      expect(friend.friends).not_to include(user2)
    end

    it 'is valid with reject_friend working' do
      user2.send_friend_request(friend)
      friend.reject_friend(user2)
      expect(friend.friends).not_to include(user2)
    end

    it 'is valid with cancel_friend working' do
      user2.send_friend_request(friend)
      user2.cancel_friend(friend)
      expect(friend.friends).not_to include(user2)
    end

    it 'is valid with delete_friend working' do
      user2.send_friend_request(friend)
      friend.confirm_friend(user2)
      friend.delete_friend(user2)
      expect(friend.friends).not_to include(user2)
    end

    it 'is valid with friend? true' do
      user2.send_friend_request(friend)
      friend.confirm_friend(user2)
      expect(friend.friend?(user2)).to be_truthy
    end
 
    it 'is valid with request_sent? true' do
      user2.send_friend_request(friend)
      expect(user2.request_sent?(friend)).to be_truthy
    end

    it 'is valid with request_received? true' do
      user2.send_friend_request(friend)
      expect(friend.request_received?(user2)).to be_truthy
    end

    it 'is valid with feeds include both friend posts' do
      post1 = Post.create(content: 'User post', user_id: user2.id)
      post2 = Post.create(content: 'Friend post', user_id: friend.id)
      user2.send_friend_request(friend)
      friend.confirm_friend(user2)
      expect(user2.feed).to include(post1)
      expect(user2.feed).to include(post2)
    end
  end

  context 'It has Associations' do
    it { should have_many(:friendships) }
    it { should have_many(:received_friendships) }
    it { should have_many(:friends) }
    it { should have_many(:pending_friends) }
  end
end
