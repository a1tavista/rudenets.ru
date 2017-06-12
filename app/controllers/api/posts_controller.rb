class Api::PostsController < Api::BaseController
  def index
    @posts = Post.all
    respond_with(@posts)
  end

  def create
    @post = Post.create!(post_params)
    Entry.create!(taxonomy: @post)
    respond_with(@post)
  end

  private

  def post_params
    params.require(:post).permit(:title)
  end
end
