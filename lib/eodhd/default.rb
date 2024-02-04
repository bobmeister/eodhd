require 'faraday'
require 'faraday_middleware'
require 'eodhd/configurable'
require 'eodhd/error/client_error'
require 'eodhd/error/server_error'
require 'eodhd/response/parse_json'
require 'eodhd/response/raise_error'
require 'eodhd/version'

module Eodhd
  module Default
    ENDPOINT = 'https://eodhd.com/api' unless defined? Eodhd::Default::ENDPOINT

    VERSION = 'v1' unless defined?(Eodhd::Default::VERSION)

    CONNECTION_OPTIONS = {
      :headers => {
        :accept => 'application/json',
        :user_agent => "eodhd Ruby Gem #{Eodhd::VERSION}",
      },
      :request => {
        :open_timeout => 5,
        :timeout => 10,
      }
    } unless defined? Eodhd::Default::CONNECTION_OPTIONS

    MIDDLEWARE = Faraday::RackBuilder.new do |builder|
      # Convert request params to "www-form-urlencoded"
      builder.use Faraday::Request::UrlEncoded
      # Parse JSON response bodies using MultiJson
      builder.use Eodhd::Response::ParseJson
      # # Handle 4xx server responses
      builder.use Eodhd::Response::RaiseError, Eodhd::Error::ClientError
      # # Handle 5xx server responses
      builder.use Eodhd::Response::RaiseError, Eodhd::Error::ServerError
      # Set Faraday's HTTP adapter
      builder.adapter Faraday.default_adapter
    end unless defined? Eodhd::Default::MIDDLEWARE

    class << self
      # @return [Hash]
      def options
        Hash[Eodhd::Configurable.keys.map { |key| [key, send(key)] }]
      end

      # @return [String]
      def access_key
        ENV['MARKETSTACK_API_ACCESS_KEY']
      end

      # @return [String]
      def endpoint
        ENDPOINT
      end

      def version
        VERSION
      end

      def connection_options
        CONNECTION_OPTIONS
      end

      # @note Faraday's middleware stack implementation is comparable to that of Rack middleware.  The order of middleware is important: the first middleware on the list wraps all others, while the last middleware is the innermost one.
      # @see https://github.com/technoweenie/faraday#advanced-middleware-usage
      # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
      # @return [Faraday::Builder]
      def middleware
        MIDDLEWARE
      end
    end
  end
end