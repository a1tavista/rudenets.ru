module Webhooks
  class TelegramController < ApplicationController
    skip_before_action :verify_authenticity_token

    def update
      return head :not_found if params[:key] != ENV["TELEGRAM_WEBHOOK_KEY"]
      return head :ok if params.dig(:callback_query).blank?

      publication_id = params.dig(:callback_query, :data)
      query_id = params.dig(:callback_query, :id)

      publication = Publication.find(publication_id)
      publication.publish_event(Events::ReactionReceived, {
        query_id: query_id,
        username: params.dig(:callback_query, :from, :id),
        user: params.dig(:callback_query, :from),
      })

      TelegramBot.new.answer_to_callback_query(query_id, text: "Спасибо!")
    end
  end
end
