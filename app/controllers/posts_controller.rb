class PostsController < ApplicationController
  load_and_authorize_resource

  def edit
    render layout: "editor"
  end
end
