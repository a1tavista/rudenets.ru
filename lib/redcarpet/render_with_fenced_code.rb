class Redcarpet::RenderWithFencedCode < Redcarpet::Render::HTML
  def header(text, header_level)
    id = text.downcase.gsub(/\s/, '-')

    <<-CODE
<h#{header_level} id="#{id}" class="heading">
  <span class="heading__text">#{text}</span>  
  <a href='##{id}' class="heading__link"><i class="material-icons heading__icon">link</i></a> 
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
