class Api::PostsController < Api::BaseController
  load_resource

  def index
    @posts = Post.refreshed_order
    respond_with(@posts)
  end

  def published
    @posts = Post.refreshed_order.published
    respond_with(@posts)
  end

  def private
    @posts = Post.refreshed_order.unpublished
    respond_with(@posts)
  end

  def create
    @post = Post.create!(post_params)
    Entry.create!(taxonomy: @post)
    respond_with(@post)
  end

  def publish
    @post.entry.publish!
  end

  def update
    @post.update(post_params)
  end

  private

  def post_params
    params.require(:post).permit(:id, :title, :summary, :text, tag_list: [])
  end
end
