module Api
  module Posts
    class CoverImagesController < BaseController
      def create
        @post = Publication::Post.find(params[:post_id])
        @post.update(cover_image: params[:file])
        @post.publish_event(Events::PostCoverImageUploaded)
      end

      def shaped
        @post = Publication::Post.find(params[:post_id])
        @post.publish_event(
          Events::PostCoverImageTransformationRequested,
          shapes_number: params[:shapes_number],
          mode: params[:mode]
        )
      end
    end
  end
end
