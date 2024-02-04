require 'eodhd/error/server_error'

module Eodhd
  class Error
    # Raised when Eodhd returns the HTTP status code 504
    class GatewayTimeout < Eodhd::Error::ServerError
      HTTP_STATUS_CODE = 504
      MESSAGE = "The Eodhd servers are up, but the request couldn't be serviced due to some failure within our stack. Try again later."
    end
  end
end