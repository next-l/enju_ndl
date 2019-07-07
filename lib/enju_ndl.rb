require 'enju_ndl/engine'
require 'open-uri'

module EnjuNdl
  class RecordNotFound < StandardError
  end

  class InvalidIsbn < StandardError
  end
end
