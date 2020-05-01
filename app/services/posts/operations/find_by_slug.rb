require "dry/transaction/operation"

module Posts
  module Operations
    class FindBySlug
      include Dry::Transaction::Operation

      def call(slug:)
        # First attempt: Try to load post by slug
        publication = Publication::Post.find_by_slug(slug)
        return Success(publication) unless publication.blank?

        # Second attempt: Try to load post by aliased slug
        publication = Publication::AlternateSlug.find_by(slug: slug)&.publication
        publication.present? ? Success(publication) : Failure(publication)
      end
    end
  end
end
