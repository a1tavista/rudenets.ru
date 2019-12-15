module Links
  class ParseLink
    include Dry::Transaction

    USERAGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.56 Safari/536.5".freeze

    step :url_correct?
    step :parse_url

    def url_correct?(input)
      check_url_connectivity(input[:url])
    rescue => e
      Failure(errors: [e], code: :exception_caught)
    end

    def parse_url(input)
      og = OGP::OpenGraph.new(input[:response])
      Success(opengraph: og)
    rescue => e
      Failure(errors: [e], code: :exception_caught)
    end

    private

    def check_url_connectivity(url)
      response = make_request_by(url)

      return check_url_connectivity(response["location"]) if response.is_a?(Net::HTTPRedirection)

      !["4", "5"].include?(response.code[0]) ?
          Success(url: url, response: response.body) :
          Failure(errors: [response.code], code: :http_error_caught)
    end

    def make_request_by(url)
      url = URI.parse(url)
      path = url.path if url.path.present?

      request = Net::HTTP.new(url.host, url.port)
      request.use_ssl = url.scheme == "https"
      request.request_get(path || "/", "User-Agent": USERAGENT)
    end
  end
end
