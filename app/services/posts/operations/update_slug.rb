require "dry/transaction/operation"
require "dry/monads"

module Posts
  module Operations
    class UpdateSlug
      include Dry::Transaction::Operation
      include Dry::Monads[:maybe]

      def call(input)
        post = input[:post]

        return if input[:publishing_time].blank?
        return if post.blank?

        slug_date = I18n.l(input[:publishing_time], format: :slug)
        slug = Maybe(input[:slug])
          .fmap { |slug| [slug_date, slug].join("-") }
          .value_or { generate_slug(post, slug_date: slug_date) }

        Post::Alias.create(post: post, slug: post.slug) if need_create_alias?(post, slug)
        post.update(slug: slug)

        input
      end

      private

      def generate_slug(post, slug_date:)
        slug_title = Russian.translit(post.title).parameterize.downcase
        [slug_date, slug_title].join("-")
      end

      def need_create_alias?(post, slug)
        return false if post.slug.blank?

        post.slug != slug
      end
    end
  end
end
