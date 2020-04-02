module ApplicationHelper
  def menu_link_to(link_text, link_path, icon)
    class_name = current_page?(link_path) ? 'navbar-item is-active' : 'navbar-item'

    # link_to link_text, link_path,class:class_name
    # content_tag(:a,href: link_path,link_text, class: class_name)
    content_tag :a, href: link_path.to_s, class: class_name do
      fa_icon(icon.to_s, text: link_text.to_s)
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      
      link_to(post_like_path(id: like.id, post_id: post.id), {method: :delete, class: "button is-danger is-rounded is-small"}) do
        concat content_tag :span,fa_icon("heart"), class:"icon"      
        concat content_tag :span,  post.likes.count    
      end
      # content_tag :a,href:post_like_path(id: like.id, post_id: post.id), class: 'tag is-danger is-rounded',id:'add_friend',method: :delete do
      # end
    else
      link_to(post_likes_path(post_id: post.id), {method: :post, class: "button is-default is-rounded is-small"}) do
        concat content_tag :span,fa_icon("heart"), class:"icon"      
        concat content_tag :span,  post.likes.count    
      end
    end
  end

  def send_friendship_button(user)
    return nil if current_user.id == user.id 
    if current_user.request_sent?(user)
      link_text="Awaiting"
      icon="circle"
      class_name="tag is-rounded "
      content_tag :span, class: class_name do
        concat content_tag :span,fa_icon(icon.to_s), class:"icon"      
        concat content_tag :span,link_text      
      end
    else
      class_name= "button is-rounded is-small"
      link_text ="Add Friend"
      icon ="plus"
      content_tag :button, class: class_name,id:'add_friend' do
        concat content_tag :span,fa_icon(icon.to_s), class:"icon"      
        concat content_tag :span,link_text      
      end
    end

    

    
  end
  def answer_friendship_button(user)
    return nil if current_user.id == user.id 
    class_name= "tag is-rounded is-small"
    link_path="#"
    link_text ="Accept Friend"
    icon ="plus"

    content_tag :button, class: class_name do
      concat content_tag :span,fa_icon(icon.to_s), class:"icon"      
      concat content_tag :span,link_text      
    end

    
  end

  def accept_friendship(user)
    form_tag({:controller => "friendships", :action => "search"}, :method => "get", :class => "nifty_form")

  end

end
