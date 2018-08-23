class Redcarpet::RenderWithFencedCode < Redcarpet::Render::HTML
  def header(text, header_level)
    id = text.downcase.gsub(/\s/, '-')

    <<-CODE
<h#{header_level} id="#{id}">
  <a href='##{id}'><i class="material-icons" style='font-size: 18px; vertical-align: middle;'>link</i></a> 
  <span style='vertical-align: middle;'>#{text}</span>
</h#{header_level}>
    CODE
  end

  def block_code(code, language)
    <<-CODE
<pre><code class="language-#{language}">#{code}</code></pre>
    CODE
  end

  def list_item(text, list_type)
    if text.start_with?('[ ]')
      text.
        sub('[ ]', '<input type="checkbox" disabled="true">').
        insert(0, '<li class="li__checkboxed">').
        insert(-1, '</li>')
    elsif text.start_with?('[x]')
      text.
        sub('[x]', '<input type="checkbox" checked="true" disabled="true">').
        insert(0, '<li class="li__checkboxed">').
        insert(-1, '</li>')
    else
      "<li>#{text}</li>"
    end
  end
end
