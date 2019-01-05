module Kramdown
  module Converter
    class Custom < Html
      def convert_header(element, indent)
        attr = element.attr.dup
        if @options[:auto_ids] && !attr['id']
          attr['id'] = generate_id(element.options[:raw_text])
        end
        attr['class'] ||= 'heading'

        @toc << [element.options[:level], attr['id'], element.children] if attr['id'] && in_toc?(element)
        level = output_header_level(element.options[:level])

        inner_html = <<-CODE
  <span class="heading__text">#{inner(element, indent)}</span>
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
end
