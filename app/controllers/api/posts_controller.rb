class Api::PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_login

  def create
    @post = Post.create!(post_params)
    Entry.create!(taxonomy: @post)
  end

  private

  def post_params
    params.require(:post).permit(:title)
  end
end
