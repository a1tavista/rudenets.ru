require 'open-uri'

class Api::LinksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_login

  def parse
    @url = params[:url]
    if is_url_correct?(@url)
      @og = OpenGraph.new(@url)
      @success = true
    else
      @success = false
    end
  end

  def create
    @link = Link.new(link_params)
    @link.remote_image_url = params[:link][:image]
    @link.save!
    Entry.create!(published: true, published_at: Time.current, taxonomy: @link)
  end

  private

  def link_params
    params.require(:link).permit(:title, :description, :url, :image, :summary).except(:image)
  end

  def is_url_correct?(url)
    url = URI.parse(url)
    req = Net::HTTP.new(url.host, url.port)
    req.use_ssl = (url.scheme == 'https')
    path = url.path if url.path.present?
    res = req.request_head(path || '/')
    if res.kind_of?(Net::HTTPRedirection)
      is_url_correct?(res['location']) # Go after any redirect and make sure you can access the redirected URL
    else
      !%W(4 5).include?(res.code[0]) # Not from 4xx or 5xx families
    end
  rescue Errno::ENOENT
    false # false if can't find the server
  end
end
