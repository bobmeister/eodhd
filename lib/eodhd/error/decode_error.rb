require 'eodhd/error'

module Eodhd
  class Error
    # Raised when JSON parsing fails
    class DecodeError < Eodhd::Error
    end
  end
end