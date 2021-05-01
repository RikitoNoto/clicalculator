require "./*"

# This class allow you create operators from the formula.
# This class never create as instance,
# because all its methods are class methods.
class OperatorManager

  # all operators that this class management.
  @@operators = [Add, Sub, Multiplied, Division, Parenthese]

  # the struct is used when OperatorManager exchange the operator infomations in between the methods.
  private struct OperatorInfo
    property operator_index, size, left_value, right_value, priority
    @left_value : String?
    @right_value : String?
    def initialize(@operator_index = -1, @size = Int32::MIN, @left_value = nil, @right_value = nil, @priority = Int32::MIN)
    end
  end

  private def self.operators
    return @@operators
  end

  #search a class in operators from the symbol
  #return the class and you allow create the instance of that class by method chain.
  #if the received symbol do not define any Operator,
  #this function return Nil class.
  # ###params
  # symbol: A symbol of Operator.
  #```
  #op = OperatorManager.operator_factory("+") # => op : Add instance
  #```
  def self.operator_factory(symbol : String) : Class
    self.operators.each do |op|
      if(symbol == op.symbol)
        return op
      end
    end

    return Nil
  end

  #this function create Operator from the formula string.
  #if the received formula is the invalid formula,
  #this function return nil.
  def self.create_formula(formula : String) : Operator?
    matchs = [] of OperatorInfo
    self.operators.each_with_index do |op, i|
      if(values = self.search_operator(op, i, formula))
        matchs << values
      end
    end
    op_info = self.operators_select(matchs)
    if(op_info)
      return self.operators[op_info.operator_index].new(Literal.new(op_info.left_value), Literal.new(op_info.right_value))
    end
    return nil
  end

  private def self.search_operator(op : Class, op_index : Int32, formula : String) : OperatorInfo?
    md = op.search(formula)
    if(md)
      return OperatorInfo.new(op_index, md.size, md.left_value, md.right_value, op.priority)
    else
      return nil
    end
  end

  private def self.operators_select(operators : Array) : OperatorInfo?
    last_operator = OperatorInfo.new()

    operators.each do |op_info|#OperatorInfo
      op = self.operators[op_info.operator_index]
      if(self.in_parenthese?(op_info.left_value))
        next
      elsif(op.priority > last_operator.priority || (op.priority == last_operator.priority && op_info.size > last_operator.size))
        #the operator is selected when its priority is higher than highest priority in current or
        #its priority is same to highest priority in current and its order of appearence in the formula is faster than fastest in current.
        last_operator = op_info
      end
    end

    if(!last_operator.left_value && !last_operator.right_value && last_operator.size == Int32::MIN)
      return nil
    else
      return last_operator
    end
  end

  private def self.in_parenthese?(left_value : String?) : Bool
    if(left_value)
      if(left_value.count('(') == left_value.count(')'))
        return false
      else
        return true
      end
    end
    return false
  end
end
