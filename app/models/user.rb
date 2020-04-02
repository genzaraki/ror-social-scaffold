class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :sent_friendships, class_name: 'Friendship', foreign_key: 'sender_id'
  has_many :received_friendships, class_name: 'Friendship', foreign_key: 'receiver_id'

  def friends
    sent_friendship_requests    = sent_friendships.map{|friendship| friendship.receiver if friendship.accepted}
    received_friendship_requests = received_friendships.map{|friendship| friendship.sender if friendship.accepted}
    (sent_friendship_requests+received_friendship_requests).compact
  end

  def pending_friends
    sent_friendships.map { |friendship| friendship.receiver unless friendship.accepted }.compact
  end

  def friend_requests
    received_friendships.map { |friendship| friendship.sender unless !friendship.accepted==false }.compact
  end
  
 
  def confirm_friend(user)
    friendship = received_friendships.find { |friendship| friendship.sender == user }
    friendship.accepted = true    
    friends << friendship
    friendship.save
  end
  
  
  def reject_friend(user)
    friendship = received_friendships.find { |friendship| friendship.sender == user }
    friendship.delete
  end

  def cancel_friend(user)
    friendship = sent_friendships.find { |friendship| friendship.receiver == user }    
    friendship.delete
  end

  def delete_friend(user)
    friendship1 = sent_friendships.find { |friendship|  friendship.sender == user }
    friendship2 = received_friendships.find { |friendship|  friendship.sender == user }   
    friendship1.delete unless friendship1.nil?
    friendship2.delete unless friendship2.nil?
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
    friends_posts = friends.map(&:id)
    friends_posts.join(',')
    Post.where('user_id IN (:friends_posts)',friends_posts: friends_posts, user_id: id).to_a
  end
end
