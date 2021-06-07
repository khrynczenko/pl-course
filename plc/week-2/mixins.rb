# In this example we make a mixin that has two methods `add` and `double`
# where `double` is defined in terms of `add`, and `add` should be defined
# by a class that includes this mixin.

module Add # Definition of a mixin
  def add x
    raise "unimplemented"
  end

  def double
    self.add self
  end
end

class Integer
  include Add
  def add x
    self + x
  end
end

class String
  include Doubler
  def add x
    self + x
  end
end
