module Handlers
  module InternalHandlers
    class OptimizeLinkImage < BaseHandler
      def handle_event
        publication = Publication::Link.find(event.data[:publication_id])
        publication.cover_image_attacher.create_derivatives
        publication.save
      end
    end
  end
end
