class PagesController < ApplicationController
  load_resource find_by: :url, only: [:show]

  def robots
    @host = application_host
  end

  private

  def application_host
    return ENV.fetch('APPLICATION_HOST') if Rails.env.production?

    ENV.fetch('APPLICATION_HOST', 'localhost:3000')
  end
end
