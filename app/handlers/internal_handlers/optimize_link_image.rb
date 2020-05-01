module InternalHandlers
  class OptimizeLinkImage < BaseHandler
    def handle_event
      link = Publication::Link.find(event.data[:link_id])
      link.image_attacher.create_derivatives
      link.save
    end
  end
end
