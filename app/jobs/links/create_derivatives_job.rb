module Links
  class CreateDerivativesJob < ApplicationJob
    def perform(link_id)
      link = Link.find(link_id)
      link.image_attacher.create_derivatives
      link.save
    end
  end
end
