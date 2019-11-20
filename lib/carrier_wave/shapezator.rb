module CarrierWave
  module Shapezator
    extend ActiveSupport::Concern

    module ClassMethods
      def shaperize_image
        process :shaperize_image
      end
    end

    def shaperize_image
      return if ENV['SHAPEZATOR_API_URL'].nil?

      cache_stored_file! unless cached?
      response = build_request(api_endpoint(shapes_number: number_of_shapes), current_path).execute
      FileUtils.cp(response.file.path, current_path)

      File.new(current_path, 'rb')
    end

    private

    def build_request(api_url, path)
      RestClient::Request.new(
        method: :post,
        url: api_url,
        payload: {
            multipart: true,
            myFile: File.new(path, 'rb')
        },
        raw_response: true,
        read_timeout: 600,
        open_timeout: 600,
        log: Logger.new(STDOUT)
      )
    end

    def api_endpoint(shapes_number: 200)
      ENV.fetch('SHAPEZATOR_API_URL') + "?numOfShapes=#{shapes_number}"
    end
  end
end
