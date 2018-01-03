module TextHelper
  REDCARPET_OPTIONS = {
    autolink: true,
    footnotes: true,
    tables: true,
    fenced_code_blocks: true,
    strikethrough: true
  }.freeze

  def to_markdown(text)
    return nil if text.nil?
    markdown = Redcarpet::Markdown.new(::Redcarpet::RenderWithFencedCode, REDCARPET_OPTIONS)
    html = markdown.render(text)
    to_smarty(html)
  end

  def to_smarty(html)
    return nil if html.nil?
    Redcarpet::Render::SmartyPants.render(html).html_safe
  end
end
