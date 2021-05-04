require "./operator"
class Multiplied < Operator
  @@symbol = "*"
  @@priority = 15


  def calculate
    left_value = self.left_value
    right_value = self.right_value
    if(left_value && right_value)
      return left_value.to_f * right_value.to_f
    end
  end
end
