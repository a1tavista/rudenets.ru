module InternalHandlers
  class TransformCoverImage < BaseHandler
    def handle_event
      post = Publication::Post.find(event.data[:post_id])
      post.cover_image_attacher.create_derivatives(
        shapes_number: event.data[:shapes_number],
        mode: event.data[:mode]
      )
      post.save

      post.publish_event(
        Events::PostCoverImageTransformed,
        shapes_number: params[:shapes_number],
        mode: params[:mode]
      )
    end
  end
end
