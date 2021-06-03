class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def distFromOrigin
    Math.sqrt(x * x + y * y)
  end
end

class ColorPoint < Point
  attr_accessor :color

  def initialize(x, y, c="red")
    super(x, y)
    @color = c
  end
end
