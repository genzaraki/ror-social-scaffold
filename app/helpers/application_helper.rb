module ApplicationHelper
  def menu_link_to(link_text, link_path, icon)
    class_name = current_page?(link_path) ? 'navbar-item is-active' : 'navbar-item'

    content_tag :a, href: link_path.to_s, class: class_name do
      fa_icon(icon.to_s, text: link_text.to_s)
    end
  end

  
end
