class PagesController < ApplicationController
  load_resource find_by: :url, only: [:show]
end
