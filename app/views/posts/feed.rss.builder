xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title default_tags[:site]
    xml.description default_tags[:description]
    xml.link root_url

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description post.abstract
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.link post_url(post.slug)
        xml.guid post_url(post.slug)
      end
    end
  end
end
