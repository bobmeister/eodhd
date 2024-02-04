require 'eodhd/error/client_error'

module Eodhd
  class Error
    # Raised when Eodhd returns the HTTP status code 404
    class UnprocessableEntity < Eodhd::Error::ClientError
      HTTP_STATUS_CODE = 422
    end
  end
end