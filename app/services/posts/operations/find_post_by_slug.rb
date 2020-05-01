require "dry/transaction/operation"

module Posts
  module Operations
    class FindPostBySlug
      include Dry::Transaction::Operation

      def call(slug:)
        # First attempt: Try to load post by slug
        post = Publication::Post.find_by_slug(slug)
        return Success(post) unless post.blank?

        # Second attempt: Try to load post by aliased slug
        post = Post::Alias.find_by(slug: slug)&.post
        post.present? ? Success(post) : Failure(post)
      end
    end
  end
end
