module Api
  class ImagesController < BaseController
    def index
      @all_images = Image.all
      @images = @all_images.page(params[:page]).per(20).order(id: :desc)
    end

    def create
      @image = Image.create(file: params[:file])
    end
  end
end
