require 'eodhd/error/client_error'

module Eodhd
  class Error
    # Raised when Eodhd returns the HTTP status code 403
    class Forbidden < Eodhd::Error::ClientError
      HTTP_STATUS_CODE = 403
    end
  end
end