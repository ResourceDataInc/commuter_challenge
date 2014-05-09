module ApplicationHelper
  def title(content)
    content_for :title, content
  end

  def header_link_to(body, url)
    klass = request.path.include?(url) ? "active" : nil
    content_tag :li, class: klass do
      link_to body, url
    end
  end
end
