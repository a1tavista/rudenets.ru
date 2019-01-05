module Api
  class PostsController < BaseController
    load_resource

    def index
      @posts = Post.refreshed_order
      respond_with(@posts)
    end

    def create
      @post = Post.create!(post_params)
      Entry.create!(taxonomy: @post)
      respond_with(@post)
    end

    def publish
      @post.entry.publish!
      @post.update_canonical_url
      render :show
    end

    def unpublish
      @post.entry.unpublish!
      render :show
    end

    def update
      @post.update(post_params)
    end

    def destroy
      @post.destroy
    end

    private

    def post_params
      params.require(:post).except(:entry).permit(:id, :title, :summary, :text, tag_list: [])
    end
  end
end
