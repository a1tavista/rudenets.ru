module Posts
  class CreateDerivativesJob < ApplicationJob
    def perform(post_id, shapes_number, mode)
      post = Post.find(post_id)
      post.cover_image_attacher.create_derivatives(shapes_number: shapes_number, mode: mode)
      post.save
    end
  end
end
