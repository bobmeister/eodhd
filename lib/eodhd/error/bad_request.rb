require 'eodhd/error/client_error'

module Eodhd
  class Error
    # Raised when Eodhd returns the HTTP status code 400
    class BadRequest < Eodhd::Error::ClientError
      HTTP_STATUS_CODE = 400
    end
  end
end