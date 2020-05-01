module Handlers
  module InternalHandlers
    class OptimizeImage < BaseHandler
      def handle_event
        image = Image.find(event.data[:image_id])
        image.image_attacher.create_derivatives
        image.save

        image.publish_event(Events::ImageOptimized, causation_id: event.event_id)
      end
    end
  end
end
