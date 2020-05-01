module Webhooks
  class TelegramController < ApplicationController
    skip_before_action :verify_authenticity_token

    def update
      # TODO
      raise RuntimeError if params[:key] != ENV["TELEGRAM_WEBHOOK_KEY"]

      publication_id = params.dig(:callback_query, :data)
      publication = Publication.find(publication_id)
      publication.increment!(:reactions_count)

      publication
    end
  end
end
