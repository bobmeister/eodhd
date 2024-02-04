require 'eodhd/error'

module Eodhd
  class Error
    # Raised when Eodhd returns a 4xx HTTP status code or there's an error in Faraday
    class ClientError < Eodhd::Error
      MESSAGE = "Client Error"

      # Create a new error from an HTTP environment
      #
      # @param response [Hash]
      # @return [Eodhd::Error]
      def self.from_response(response={})
        new(response[:body], response[:response_headers])
      end

      # Initializes a new ServerError object
      #
      # @param message [String]
      # @param response_headers [Hash]
      # @return [Eodhd::Error::ServerError]
      def initialize(message=nil, response_headers={})
        super((message || self.class.const_get(:MESSAGE)), response_headers)
      end

    end
  end
end