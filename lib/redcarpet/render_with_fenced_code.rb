class Redcarpet::RenderWithFencedCode < Redcarpet::Render::HTML
  def block_code(code, language)
    <<-CODE
      <pre class="language-#{language}"><code class="language-#{language}">#{code}</code></pre>
    CODE
  end
end
