class Api::LabelsController < Api::BaseController
  def index
    @labels = Post.tag_counts
    respond_with(@labels)
  end
end
