module Api
  class ImagesController < BaseController
    def index
      @all_images = Image.all
      @images = @all_images.page(params[:page]).per(params[:per] || 40).order(id: :desc)
    end

    def create
      @image = Image.create(image: params[:file])
      ::Images::CreateDerivativesJob.perform_later(@image.id)
    end
  end
end
