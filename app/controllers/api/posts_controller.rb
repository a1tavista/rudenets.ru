module Api
  class PostsController < BaseController
    load_resource except: [:create], class: Publication::Post

    def index
      @posts = Publication::Post.sorted_by_publishing_time.order(updated_at: :desc)
      respond_with(@posts)
    end

    def create
      ::Posts::CreatePost.new.call(attributes: post_params.to_h) do |monad|
        monad.success { |result| @post = result[:post] }
        monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
      end
    end

    def update
      ::Posts::UpdatePost.new.call(post: @post, attributes: post_params.to_h) do |monad|
        monad.success { |result| @post = result[:post] }
        monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
      end
    end

    def destroy
      ::Posts::RemovePost.new.call(post: @post) do |monad|
        monad.success { |result| @post = result[:post] }
        monad.failure { |result| respond_with_error(result, status: :unprocessable_entity) }
      end
    end

    private

    def post_params
      params.require(:post).permit!
    end
  end
end
