class Vector
  # public by default
  def initialize x=0, y=0
    @x = x
    @y = y
  end

  attr_reader :x, :y

  # attr_reader makes getters
  # bellow code is unnecessary
  #def x
    #@x
  #end

  #def y
    #@y
  #end

  def add! rhs
    @x = x + rhs.x
    @y = y + rhs.y
    self
  end

  def add rhs
    Vector.new(@x + rhs.x, @y + rhs.y)
  end

  def + rhs
    Vector.new(@x + rhs.x, @y + rhs.y)
  end

  def show
    print(@x, @y)
  end

end

