# frozen_string_literal: true

class PostsController < ApplicationController
  include SeoHelper
  load_and_authorize_resource find_by: :slug

  def index
    @entries = Entry.includes(:taxonomy)
                    .published
                    .sorted_by_publishing_time
                    .where('taxonomy_type = ?', Post)
                    .page(params[:page])
    render 'entries/index'
  end

  def show
    set_meta_tags(post_tags(@post))
    @post
  end

  def preview
    html = render_to_string(layout: 'preview')
    blob = IMGKit.new(html, quality: 100, width: 1920, height: 900).to_img(:png)
    send_data(blob, type: 'image/png', disposition: 'inline')
  end
end
