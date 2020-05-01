module Events
  PostPublished = Class.new(RailsEventStore::Event)

  PostArchived = Class.new(RailsEventStore::Event)

  PostCoverImageUploaded = Class.new(RailsEventStore::Event)
  PostCoverImageTransformationRequested = Class.new(RailsEventStore::Event)
  PostCoverImageTransformed = Class.new(RailsEventStore::Event)

  ReactionReceived = Class.new(RailsEventStore::Event)

  LinkPublished = Class.new(RailsEventStore::Event)

  ChannelPostPublished = Class.new(RailsEventStore::Event)

  ImageUploaded = Class.new(RailsEventStore::Event)
  ImageOptimized = Class.new(RailsEventStore::Event)
end
