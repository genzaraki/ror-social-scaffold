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

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like

      link_to(post_like_path(id: like.id, post_id: post.id), method: :delete, class: 'button is-danger is-rounded is-small') do
        concat content_tag :span, fa_icon('heart'), class: 'icon'
        concat content_tag :span, post.likes.count
      end

    else
      link_to(post_likes_path(post_id: post.id), method: :post, class: 'button is-default is-rounded is-small') do
        concat content_tag :span, fa_icon('heart'), class: 'icon'
        concat content_tag :span, post.likes.count
      end
    end
  end

  def send_friendship_button(user)
    return nil if current_user.id == user.id

    if current_user.request_sent?(user)
      link_text = 'Awaiting'
      icon = 'circle'
      class_name = 'tag is-rounded '
      content_tag :span, class: class_name do
        concat content_tag :span, fa_icon(icon.to_s), class: 'icon'
        concat content_tag :span, link_text
      end
    else
      class_name = 'button is-rounded is-small'
      link_text = 'Add Friend'
      icon = 'plus'
      content_tag :button, class: class_name, id: 'add_friend' do
        concat content_tag :span, fa_icon(icon.to_s), class: 'icon'
        concat content_tag :span, link_text
      end
    end
  end

  def answer_friendship_button(user)
    return nil if current_user.id == user.id

    class_name = 'tag is-rounded is-small'

    link_text = 'Accept Friend'
    icon = 'plus'

    content_tag :button, class: class_name do
      concat content_tag :span, fa_icon(icon.to_s), class: 'icon'
      concat content_tag :span, link_text
    end
  end

  def accept_friendship(user)
    render 'partials/accept_friend', user: user unless current_user.friend?(user)
  end

  def reject_friendship(user)
    render 'partials/reject_friend', user: user unless current_user.friend?(user)
  end

  def cancel_friendship(user)
    render 'partials/cancel_friend', user: user
  end
end
