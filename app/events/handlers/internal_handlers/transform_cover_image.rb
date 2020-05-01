module Handlers
  module InternalHandlers
    class TransformCoverImage < BaseHandler
      def handle_event
        publication = Publication::Post.find(event.data[:publication_id])
        publication.cover_image_attacher.create_derivatives(
          shapes_number: event.data[:shapes_number],
          mode: event.data[:mode]
        )
        publication.save

        publication.publish_event(
          Events::PostCoverImageTransformed,
          shapes_number: params[:shapes_number],
          mode: params[:mode]
        )
      end
    end
  end
end
