module ApplicationHelper
  def menu_link_to(link_text, link_path, icon)
    class_name = current_page?(link_path) ? 'navbar-item is-active' : 'navbar-item'

    content_tag :a, href: link_path.to_s, class: class_name do
      fa_icon(icon.to_s, text: link_text.to_s)
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like

      link_to(post_like_path(
                id: like.id,
                post_id: post.id
              ),
              method: :delete,
              class: 'button is-danger is-rounded is-small') do
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
end
