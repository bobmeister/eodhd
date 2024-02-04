require 'eodhd/error/server_error'

module Eodhd
  class Error
    # Raised when Eodhd returns the HTTP status code 500
    class InternalServerError < Eodhd::Error::ServerError
      HTTP_STATUS_CODE = 500
      MESSAGE = "Something is technically wrong."
    end
  end
end