abstract class Operator
  SYMBOL = ""
  @left_value : String | Nil
  @right_value : String | Nil

  def initialize(@formula : String)
  end

  def left_value
    return @left_value
  end

  def right_value
    return @right_value
  end

  abstract def calculate()
end
