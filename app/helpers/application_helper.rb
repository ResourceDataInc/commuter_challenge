module ApplicationHelper
  def linkify(text)
    text.gsub(/\b((https?:\/\/)([^\s]+))\b/) { link_to $1, $1 }.html_safe
  end

  def pretty_date(date)
    date.strftime "%B %e, %Y"
  end
end
