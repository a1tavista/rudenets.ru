module Subscriptions
  class InternalHandlers
    def self.subscribe(event_store)
      event_store.subscribe(::InternalHandlers::OptimizeImage, to: [Events::ImageUploaded])
      event_store.subscribe(::InternalHandlers::OptimizeLinkImage, to: [Events::LinkPublished])
      event_store.subscribe(::InternalHandlers::TransformCoverImage, to: [Events::PostCoverImageTransformationRequested])
    end
  end
end
