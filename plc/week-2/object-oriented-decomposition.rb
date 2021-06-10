# Showcase of advantages/disadvantages of oop decomposition

class Expr
  def eval
  end
end

class MyValue < Expr
  def initialize i
    @i = i
  end

  def eval @i end
end

class MyAdd < Expr
  def initialize (e1, e2)
    @e1 = e1
    @e2 = e2
  end

  def eval
    @e1.eval + @e2.eval
  end
end

# ADVANTAGE
# The advantage of using oop decomposition is that adding new data does not
# require from us any changes do the already existing code. 

class MyMultiply < Expr
  def initialize (e1, e2)
    @e1 = e1
    @e2 = e2
  end

  def eval
    @e1.eval * @e2.eval
  end
end

# We just added new kind of data without having to change any existing code!

# DISADVANTAGE
# Unfortunately, adding new operation requires from us updating existing code.
class Expr
  def has_zero
  end
end

class MyValue < Expr
  def has_zero
    @i == 0
  end
end

class MyAdd < Expr
  def has_zero
    @e1.has_zero || @e2.has_zero
  end
end

class MyMultiply < Expr
  def has_zero
    @e1.has_zero || @e2.has_zero
  end
end

# Trying to add new operation requires us to go back to all existing data
# and update their definitions.
