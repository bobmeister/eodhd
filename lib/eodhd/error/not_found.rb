require 'eodhd/error/client_error'

module Eodhd
  class Error
    # Raised when Eodhd returns the HTTP status code 404
    class NotFound < Eodhd::Error::ClientError
      HTTP_STATUS_CODE = 404
    end
  end
end