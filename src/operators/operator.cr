abstract class Operator
  @@symbol = ""

  def initialize(@left : Literal, @right : Literal)
  end

  def self.symbol
    return @@symbol
  end

  def left_value
    @left.value
  end

  def right_value
    @right.value
  end

  abstract def calculate

end
