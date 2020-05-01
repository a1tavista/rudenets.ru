require "dry/transaction/operation"
require "dry/monads"

module Posts
  module Operations
    class UpdateSlug
      include Dry::Transaction::Operation
      include Dry::Monads[:maybe]

      def call(input)
        publication = input[:publication]

        return if input[:publishing_time].blank?
        return if publication.blank?

        slug_date = I18n.l(input[:publishing_time], format: :slug)
        slug = Maybe(input[:slug])
          .fmap { |slug| [slug_date, slug].join("-") }
          .value_or { generate_slug(publication, slug_date: slug_date) }

        Publication::AlternateSlug.create(publication: publication, slug: publication.slug) if need_create_alias?(publication, slug)
        publication.update(slug: slug)

        input
      end

      private

      def generate_slug(publication, slug_date:)
        slug_title = Russian.translit(publication.title).parameterize.downcase
        [slug_date, slug_title].join("-")
      end

      def need_create_alias?(post, slug)
        return false if post.slug.blank?

        post.slug != slug
      end
    end
  end
end
