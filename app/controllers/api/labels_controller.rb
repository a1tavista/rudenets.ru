module Api
  class LabelsController < BaseController
    def index
      @labels = Post.tag_counts
      respond_with(@labels)
    end
  end
end
