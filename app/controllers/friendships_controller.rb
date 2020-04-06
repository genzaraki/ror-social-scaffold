class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  layout 'account'

  def index
    @users = current_user.friends
  end

  def received
    @users = current_user.friend_requests
  end

  def sent
    @users = current_user.pending_friends
  end

  def create
    friend = User.find(params[:user][:friend_id])
    return if current_user.friend?(friend)

    current_user.send_friend_request(friend)
    redirect_to user_friendships_sent_path(current_user), notice: 'Friend Request send!.'
  end

  def accept
    friend = User.find(params[:user][:friend_id])
    current_user.confirm_friend(friend)

    redirect_to user_friendships_path(current_user), notice: 'Friend Request Accepted!.'
  end

  def reject
    friend = User.find(params[:user][:friend_id])
    current_user.reject_friend(friend)
    redirect_to user_friendships_received_path(current_user), notice: 'Friend Request Rejected!.'
  end

  def cancel
    friend = User.find(params[:user][:friend_id])
    current_user.cancel_friend(friend)
    redirect_to user_friendships_sent_path(current_user), notice: 'Friend Request Ca!nceled.'
  end

  def destroy
    friend = User.find(params[:user][:friend_id])
    current_user.delete_friend(friend)
    redirect_to user_friendships_path(current_user), notice: 'Friend Removed!.'
  end
end
