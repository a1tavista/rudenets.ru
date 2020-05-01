module Subscriptions
  class SeoHandlers
    def self.subscribe(event_store)
      event_store.subscribe(
        ::Handlers::SeoHandlers::UpdateSitemap,
        to: [Events::PostPublished, Events::PostArchived]
      )
    end
  end
end
