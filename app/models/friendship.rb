class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"
  validates :friend_id, presence: true
  validates :user_id, presence: true
end
