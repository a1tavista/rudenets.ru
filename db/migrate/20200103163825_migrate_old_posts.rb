class MigrateOldPosts < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def up
    Post.find_each do |p|
      p.content_blocks = [{ type: 'markdown', value: p.text }]
      p.prerendered_content = Posts::Operations::PrerenderPostContent.new.call(post: p)
    end
  end
end
