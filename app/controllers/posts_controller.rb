class PostsController < ApplicationController
  include SeoHelper
  load_and_authorize_resource find_by: :slug

  def show
    set_meta_tags(post_tags(@post))
    @post
  end
end
