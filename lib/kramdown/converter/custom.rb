module Kramdown::Converter
  class Custom < Html
    def convert_header(el, indent)
      attr = el.attr.dup
      if @options[:auto_ids] && !attr['id']
        attr['id'] = generate_id(el.options[:raw_text])
      end
      attr['class'] ||= 'heading'

      @toc << [el.options[:level], attr['id'], el.children] if attr['id'] && in_toc?(el)
      level = output_header_level(el.options[:level])

      inner_html = <<-CODE
  <span class="heading__text">#{inner(el, indent)}</span>  
  <a href='##{attr['id']}' class="heading__link"><i class="material-icons heading__icon">link</i></a>
      CODE

      format_as_block_html(
        "h#{level}",
        attr,
        inner_html,
        indent
      )
    end
  end
end
