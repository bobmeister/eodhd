require 'faraday'
require 'faraday_middleware'
require 'multi_json'
# require 'marketstack/api/exchange'
# require 'marketstack/api/historical'
require 'eodhd/configurable'
# require 'marketstack/error/client_error'
# require 'marketstack/error/decode_error'

module Eodhd
  # Wrapper for the Tradier REST API
  class Client
    # include Eodhd::API::Exchange
    # include Eodhd::API::Historical
    include Eodhd::Configurable

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [Eodhd::Client]
    def initialize(options={})
      Eodhd::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || Eodhd.instance_variable_get(:"@#{key}"))
      end
    end

    # Perform an HTTP DELETE request
    def delete(path, params={})
      request(:delete, path, params)
    end

    # Perform an HTTP GET request
    def get(path, params={})
      request(:get, path, params)
    end

    # Perform an HTTP POST request
    def post(path, params={})
      request(:post, path, params)
    end

    # Perform an HTTP PUT request
    def put(path, params={})
      request(:put, path, params)
    end

    private

    # Returns a proc that can be used to setup the Faraday::Request headers
    #
    # @param method [Symbol]
    # @param path [String]
    # @param params [Hash]
    # @return [Proc]
    def request_setup(method, path, params)
      Proc.new do |request|
        request.headers[:authorization] = "Bearer #{@access_key}"
      end
    end

    def request(method, request_path, params={}, signature_params=params)
      request_setup = request_setup(method, versioned_path(request_path), params)
      connection.send(method.to_sym, versioned_path(request_path), params, &request_setup).env
    rescue Faraday::ClientError
      raise Eodhd::Error::ClientError
    rescue MultiJson::DecodeError
      raise Eodhd::Error::DecodeError
    end

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @connection ||= begin
                        connection_options = {:builder => @middleware}
                        Faraday.new(@endpoint, @connection_options.merge(connection_options))
                      end
    end

    def versioned_path(request_path)
      @version + request_path
    end

  end
end