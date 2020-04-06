class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :received_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    friends = friendships.map { |friendship| friendship.friend if friendship.accepted }
    friends.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.accepted }.compact
  end

  def friend_requests
    received_friendships.map { |friendship| friendship.user unless !friendship.accepted == false }.compact
  end

  def send_friend_request(user)
    Friendship.create(friend_id: user.id, user_id: id, accepted: nil)
  end

  def confirm_friend(user)
    friendship = received_friendships.find { |friend_ship| friend_ship.user == user }
    friendship.accepted = true
    friends << friendship
    friendship.save
    Friendship.create(friend_id: user.id, user_id: id, accepted: true)
  end

  def reject_friend(user)
    friendship1 = received_friendships.find { |friendship| friendship.user == user }
    friendship1.delete
  end

  def cancel_friend(user)
    friendship2 = friendships.find { |friendship| friendship.friend == user }
    friendship2.delete
  end

  def delete_friend(user)
    friendship1 = friendships.find { |friendship| friendship.friend == user }
    friendship1.delete
    friendship2 = received_friendships.find { |friendship| friendship.user == user }
    friendship2.delete
  end

  def friend?(user)
    friends.include?(user)
  end

  def request_sent?(user)
    pending_friends.include?(user)
  end

  def request_received?(user)
    friend_requests.include?(user)
  end

  def feed
    friends_posts = friendships.map(&:id)
    friends_posts.join(',')
    Post.where('user_id IN (:friends_posts)', friends_posts: friends_posts, user_id: id).to_a
  end
end
