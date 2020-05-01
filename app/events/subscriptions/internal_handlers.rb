module Subscriptions
  class InternalHandlers
    def self.subscribe(event_store)
      event_store.subscribe(::Handlers::InternalHandlers::OptimizeImage, to: [Events::ImageUploaded])
      event_store.subscribe(::Handlers::InternalHandlers::OptimizeLinkImage, to: [Events::LinkPublished])
      event_store.subscribe(::Handlers::InternalHandlers::TransformCoverImage, to: [Events::PostCoverImageTransformationRequested])
    end
  end
end
