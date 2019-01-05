module TextHelper
  PARSER_OPTIONS = {
    parse_block_html: true,
    parse_span_html: true,
    enable_coderay: false,
    input: 'GFM'
  }.freeze

  def from_markdown(text)
    return nil if text.nil?

    Kramdown::Document.new(text, PARSER_OPTIONS).to_custom.html_safe
  end

  def to_smarty(html)
    return nil if html.nil?

    Redcarpet::Render::SmartyPants.render(html).html_safe
  end

  def reading_time(input)
    words_per_minute = 180

    words = input.split.size
    minutes = (words / words_per_minute).floor
    minutes.positive? ? "#{minutes} мин." : 'меньше мин.'
  end
end
