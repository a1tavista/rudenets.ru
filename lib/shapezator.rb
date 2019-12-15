class Shapezator
  attr_reader :number_of_shapes, :mode

  def initialize(image, shapes_number, mode)
    @image = image
    @number_of_shapes = shapes_number || 300
    @mode = mode || 0
  end

  def call
    file = Tempfile.new(["shaped-#{Time.current.to_i}", ".png"])
    file.write(transform_image(api_endpoint(shapes_number: number_of_shapes, mode: mode)).execute.file.read)
    file.close
    file
  end

  private

  def transform_image(api_url)
    RestClient::Request.new(
      method: :post,
      url: api_url,
      payload: {
        multipart: true,
        myFile: @image,
      },
      read_timeout: 12000,
      open_timeout: 12000,
      raw_response: true
    )
  end

  def api_endpoint(shapes_number: 200, mode: 0)
    ENV.fetch("SHAPEZATOR_API_URL") + "?numOfShapes=#{shapes_number}&mode=#{mode}"
  end
end
