require 'eodhd/error/server_error'

module Eodhd
  class Error
    # Raised when Eodhd returns the HTTP status code 502
    class BadGateway < Eodhd::Error::ServerError
      HTTP_STATUS_CODE = 502
      MESSAGE = "Eodhd is down or being upgraded."
    end
  end
end