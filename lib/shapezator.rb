class Shapezator
  attr_reader :number_of_shapes

  def initialize(image, shapes_number)
    @image = image
    @number_of_shapes = shapes_number || 300
  end

  def call
    file = File.open(Rails.root.join('tmp', "image-#{Time.current.to_i}.png"), 'wb')
    file.write(transform_image(api_endpoint(shapes_number: number_of_shapes)).execute.body)
    file
  end

  private

  def transform_image(api_url)
    RestClient::Request.new(
      method: :post,
      url: api_url,
      payload: {
        multipart: true,
        myFile: @image
      },
      read_timeout: 600,
      open_timeout: 600,
    )
  end

  def api_endpoint(shapes_number: 200)
    ENV.fetch('SHAPEZATOR_API_URL') + "?numOfShapes=#{shapes_number}"
  end
end
