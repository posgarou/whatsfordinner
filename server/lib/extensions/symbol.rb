# This clever monkey patch (via Stack Overflow) allows you to write, e.g.:
#   [1,2,3,4].map(&:+.with(2)) # => [3,4,5,6]

class Symbol
  def with(*args, &block)
    ->(caller, *rest) { caller.send(self, *rest, *args, &block) }
  end
end
