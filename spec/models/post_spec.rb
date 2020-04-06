require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.new(name: 'JohnDoe', email: 'johndoe@ymail.com', password: 'password') }
  let(:post) { Post.new(content: 'A simple post content', user_id: user.id) }

  describe 'Validations' do
    it 'is valid with a content' do
      expect(post.content).to eq('A simple post content')
    end
    it 'is valid with a user_id' do
      expect(post.user_id).to eq(user.id)
    end
    it 'is valid without content' do
      post.content = nil
      expect(post.save).to eq(false)
    end
    it 'is valid withoud user_id' do
      post.user_id = nil
      expect(post.save).to eq(false)
    end
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end
end
