module FriendshipsHelper
  def friend_list(users)
    if users.count.positive?
      render 'friendships/friends', users: users
    else
      render 'friendships/no_friend_yet', message: 'You have no friend for now.'
    end
  end

  def received_requests(users)
    if users.count.positive?
      render 'friendships/received_requests', users: users
    else
      render 'friendships/no_friend_yet', message: 'You have no friend requests for now.'
    end
  end

  def sent_requests(users)
    if users.count.positive?
      render 'friendships/sent_requests', users: users
    else
      render 'friendships/no_friend_yet', message: 'You have no friend requests sent for now.'
    end
  end



  def add_friendship(user)
    render 'friendships/add_friend', user: user unless current_user.friend?(user)
  end

  def accept_friendship(user)
    render 'friendships/accept_friend', user: user unless current_user.friend?(user)
  end

  def reject_friendship(user)
    render 'friendships/reject_friend', user: user unless current_user.friend?(user)
  end

  def cancel_friendship(user)
    render 'friendships/cancel_friend', user: user
  end

  def delete_friendship(user)
    render 'friendships/delete_friend', user: user
  end

  def friendship_button(user)
    if current_user.request_received?(user)
      accept_friendship(user)
    elsif current_user.request_sent?(user)
      link_text = 'Awaiting'
      icon = 'circle'
      class_name = 'tag is-rounded '
      content_tag :span, class: class_name do
        concat content_tag :span, fa_icon(icon.to_s), class: 'icon'
        concat content_tag :span, link_text
      end

    elsif current_user.friend?(user)
      link_text = 'Friend'
      icon = 'check'
      class_name = 'tag is-rounded is-success'
      content_tag :span, class: class_name do
        concat content_tag :span, fa_icon(icon.to_s), class: 'icon'
        concat content_tag :span, link_text
      end
    else
      add_friendship(user)
    end
  end
end
