# Showcase how oop decomposition handles binary operations
# (where arguments can be of different data)
# TLDR: DOUBLE DISPATCH

class Expr
  def eval
  end
end

class MyValue < Expr
  attr_accessor :i

  def initialize i
    @i = i
  end

  def eval
    self
  end

  # first dispatch
  def add_values v
    v.add_value self
    # Below approach is wrong, as it is basically functional decomposition
    #if v.instance_of? MyValue
      #MyValue.new(i + v.i)
    #else
      #MyString.new(i.to_s + v.s)
    #end
  end

  # second dispatch
  def add_string v
    MySring.new(v.s + i.to_s)
  end

  # second
  def add_value v
    MyValue.new(i + v.i)
  end
end

class MyString < Expr
  attr_accessor :s
  def initialize s
    @s = s
  end

  def eval
    self
  end

  # first dispatch
  def add_values v
    v.add_string self
      # Below approach is wrong, as it is basically functional decomposition
      #if v.instance_of? MyString
        #MyString.new(s + v.s)
      #else
        #MyString.new(v.s + i.to_s)
      #end
  end

  # second dispatch
  def add_string v
    MyString.new(v.s + s)
  end

  #second dispatch
  def add_value v
    MyString.new(v.i.to_s + s)
  end
end

class MyAdd < Expr
  def initialize (e1, e2)
    @e1 = e1
    @e2 = e2
  end

  def eval
    @e1.eval.add_values @e2.eval
  end
end

