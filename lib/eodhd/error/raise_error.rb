require 'faraday'
require 'eodhd/error/bad_gateway'
require 'eodhd/error/bad_request'
require 'eodhd/error/forbidden'
require 'eodhd/error/gateway_timeout'
require 'eodhd/error/internal_server_error'
require 'eodhd/error/not_acceptable'
require 'eodhd/error/not_found'
require 'eodhd/error/service_unavailable'
require 'eodhd/error/too_many_requests'
require 'eodhd/error/unauthorized'
require 'eodhd/error/unprocessable_entity'

module Eodhd
  module Response
    class RaiseError < Faraday::Response::Middleware

      def on_complete(env)
        status_code = env[:status].to_i
        error_class = @klass.errors[status_code]
        raise error_class.from_response(env) if error_class
      end

      def initialize(app, klass)
        @klass = klass
        super(app)
      end

    end
  end
end