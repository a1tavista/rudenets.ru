class ProcessImagesJob < ApplicationJob
  queue_as :default

  def perform(entity_klass, entity_id)
    entity_klass.constantize.find(entity_id).process_delayed_versions!
  end
end