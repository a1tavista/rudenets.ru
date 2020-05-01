class Publication
  class ChannelPost < Publication
    def link
      "https://t-do.ru/rudenets_ru/#{message_ids&.first}"
    end

    def set_message_ids!(ids)
      ids = Array.wrap(ids)
      update(
        publication_data: publication_data.merge(
          telegram: {
            message_ids: ids,
            message_id: ids.last,
          }
        )
      )
    end

    def message_id
      publication_data.dig("telegram", "message_id")
    end

    def message_ids
      publication_data.dig("telegram", "message_ids")
    end
  end
end
