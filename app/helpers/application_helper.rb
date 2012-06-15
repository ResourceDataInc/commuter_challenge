module ApplicationHelper
  def linkify(text)
    text.gsub(/\b((https?:\/\/)([^\s]+))\b/) { link_to $1, $1 }.html_safe
  end

  def pretty_date(date)
    date.strftime "%B %e, %Y"
  end
  
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(:hard_wrap => true)
    md = Redcarpet::Markdown.new(renderer, :autolink => true)
    md.render(text).html_safe
  end
end
