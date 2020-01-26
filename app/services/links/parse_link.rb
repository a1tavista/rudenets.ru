module Links
  class ParseLink
    include Dry::Transaction
    include Dry::Monads[:maybe, :try]

    USERAGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36".freeze

    step :url_correct?
    step :parse_url

    def url_correct?(input)
      check_url_connectivity(input[:url])
    rescue => e
      Failure(errors: [e], code: :exception_caught)
    end

    def parse_url(input)
      monad = Try { OGP::OpenGraph.new(input[:response]) }.to_maybe
      og = monad.value_or { OpenGraph.new(input[:response], headers: {"User-Agent": USERAGENT}) }

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
