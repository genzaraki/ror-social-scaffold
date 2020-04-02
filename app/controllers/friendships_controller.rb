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
       
        # friend_id = params[:user][:friend_id]
        # friend_ship = Friendship.where(user_id: current_user.id).where(friend_id:friend_id  ).first
        # if friend_ship.nil?
        #     friend_ship = Friendship.create(user_id: user_id,friend_id: friend_id)
        #     redirect_to user_path(friend_id), notice: 'Friend Request send!.'
        # else
        #     friend_ship.delete
        #     redirect_to user_path(friend_id), notice: 'Friend Request canceled!.'
        # end

        receiver = User.find(params[:user][:receiver_id])
        if !current_user.friend?(receiver)
            
            friend_ship = Friendship.create(sender_id: current_user.id,receiver_id: receiver.id,accepted:nil)
            
            redirect_to user_friendships_sent_path(current_user), notice: 'Friend Request send!.'
        
        end
        
        
    end

    def accept
        user = User.find(params[:user][:sender_id])
        current_user.confirm_friend(user)
        redirect_to user_friendships_path(current_user), notice: 'Friend Request Accepted!.'
    end

    def reject
        user = User.find(params[:user][:sender_id])
        current_user.reject_friend(user)
        redirect_to user_friendships_received_path(current_user), notice: 'Friend Request Rejected!.'
    end

    def cancel
        user = User.find(params[:user][:sender_id])
        current_user.cancel_friend(user)
        redirect_to user_friendships_sent_path(current_user), notice: 'Friend Request Ca!nceled.'
    end

    def destroy
        user = User.find(params[:user][:sender_id])
        current_user.delete_friend(user)        
        redirect_to user_friendships_path(current_user), notice: 'Friend Removed!.'
    end
end
