module Api
  module Posts
    class CoverImagesController < BaseController
      def create
        @post = Post.find(params[:post_id])
        @post.update(cover_image: params[:file])
      end

      def shaped
        ::Posts::CreateDerivativesJob.perform_later(params[:post_id], params[:shapes_number], params[:mode])
      end
    end
  end
end
