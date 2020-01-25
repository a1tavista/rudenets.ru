module Images
  class CreateDerivativesJob < ApplicationJob
    def perform(image_id)
      image = Image.find(image_id)
      image.image_attacher.create_derivatives
      image.save
    end
  end
end
