class EntriesController < ApplicationController
  include Concerns::EntriesConcern

  load_and_authorize_resource class: Publication
end
