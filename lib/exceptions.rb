module Exceptions
  #Expected key or value does not exist in a hash.
  class KeyNotFoundError < StandardError; end
  class ValueNotFoundError < StandardError; end
end
