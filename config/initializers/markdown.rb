class HTMLWithPygments < Redcarpet::Render::HTML
  def block_code(code, language)
    sha = Digest::SHA1.hexdigest(code)
    Rails.cache.fetch ["code", language, sha].join('-') do
      Pygments.highlight(code, lexer: language)
    end
  end
end

MarkdownRails.configure do |config|
  config.render do |markdown_source|
    renderer = HTMLWithPygments.new(hard_wrap: true, filter_html: true)
    options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(markdown_source).html_safe
  end
end