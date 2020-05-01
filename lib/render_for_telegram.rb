class RenderForTelegram < Redcarpet::Render::HTML
  def block_code(code, language)
    super
  end

  def block_quote(quote)
    "> #{quote}"
  end

  def block_html(raw_html)
    nil
  end

  def footnotes(content)
    nil
  end

  def footnote_def(content, number)
    nil
  end

  def header(text, header_level)
    "<b>#{text}</b>\n\n"
  end

  def hrule
    "--------------------------------------\n\n"
  end

  def list(contents, list_type)
    @list_item_number = nil
    "#{contents}\n"
  end

  def list_item(text, list_type)
    if list_type == :ordered
      @list_item_number ||= 0
      @list_item_number += 1

      return "#{@list_item_number}. #{text}"
    end

    "- #{text}"
  end

  def paragraph(text)
    "#{text}\n\n"
  end

  def table(header, body)
    nil
  end

  def table_row(content)
    nil
  end

  def table_cell(content, alignment)
    nil
  end
end
