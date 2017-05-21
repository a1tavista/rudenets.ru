module TextHelper
  def to_markdown(text)
    return nil if text.nil?
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, footnotes: true, tables: true)
    html = markdown.render(text)
    to_smarty(html)
  end

  def to_smarty(html)
    return nil if html.nil?
    Redcarpet::Render::SmartyPants.render(html).html_safe
  end
end
