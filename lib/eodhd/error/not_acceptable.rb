require 'marketstack/error/client_error'

module Eodhd
  class Error
    # Raised when Eodhd returns the HTTP status code 406
    class NotAcceptable < Eodhd::Error::ClientError
      HTTP_STATUS_CODE = 406
    end
  end
end