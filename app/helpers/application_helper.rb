module ApplicationHelper
  def title(content)
    content_for :title, content
  end
end
