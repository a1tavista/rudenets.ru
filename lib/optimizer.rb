class Optimizer
  attr_reader :image

  def initialize(image)
    @image = image
  end

  def call
    optimize_image
  end

  private

  def optimize_image
    uri = URI("https://api.tinify.com/shrink")

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http|
      req = Net::HTTP::Post.new(uri.path)
      req.basic_auth "api", ENV.fetch("TINIFY_API_KEY")
      req.body = File.open(image.path).read
      req.content_type = "application/octet-stream"

      http.request(req)
    }

    optimized_image_url = JSON.parse(response.body).dig("output", "url")

    download_image_from_url(optimized_image_url)
  end

  def download_image_from_url(url)
    uri = URI(url)
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http|
      req = Net::HTTP::Get.new(uri.path)
      req.basic_auth "api", ENV.fetch("TINIFY_API_KEY")
      http.request(req)
    }

    tempfile = Tempfile.new(["image", ".png"])
    tempfile.binmode
    tempfile.write(response.body)
    tempfile
  end
end
