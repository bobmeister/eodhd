require 'eodhd/error/server_error'

module Eodhd
  class Error
    # Raised when Eodhd returns the HTTP status code 503
    class ServiceUnavailable < Eodhd::Error::ServerError
      HTTP_STATUS_CODE = 503
      MESSAGE = "Eodhd is over capacity."
    end
  end
end