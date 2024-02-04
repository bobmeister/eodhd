require 'eodhd/error/client_error'

module Eodhd
  class Error
    # Raised when Eodhd returns the HTTP status code 401
    class Unauthorized < Eodhd::Error::ClientError
      HTTP_STATUS_CODE = 401
    end
  end
end