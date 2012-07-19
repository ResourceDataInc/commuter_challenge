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
  
  def sortable(column, title=nil)
    title ||= column.titleize    
    has_sort_and_asc = 
    direction = (column == sort_column && sort_direction == "asc")  ? "desc" : "asc"
    icon = (column == sort_column) ? 
      ((sort_direction == "asc") ? 
        image_tag(nil, :class => "icon-chevron-up") 
        : image_tag(nil, :class => "icon-chevron-down")) 
      : ''
    css_class = (column == sort_column) ? "current #{icon}" : nil
    link_to  icon + title, :sort => column, :direction => direction
  end
end
