require "./*"

# This class allow you create operators from the formula.
# This class never create as instance,
# because all its methods are class methods.
class OperatorManager

  # all operators that this class management.
  @@operators = [Add, Sub, Multiplied, Division]

  # the struct is used when OperatorManager exchange the operator infomations in between the methods.
  private struct OperatorInfo
    property operator_index, size, left_value, right_value
    def initialize(@operator_index : Int32, @size : Int32, @left_value : String?, @right_value : String?)
    end
  end

  def self.operators
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
    OperatorManager.operators.each do |op|
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
    OperatorManager.operators.each_with_index do |op, i|
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
    symbol = Regex.escape(op.symbol)
    pattern = Regex.new("(.*)(#{symbol})(.*)")
    md = pattern.match(formula)
    if(md)
      return OperatorInfo.new(op_index, md[1].size, md[1], md[3])
    else
      return nil
    end
  end

  private def self.operators_select(operators : Array) : OperatorInfo?
    last_priority = Int32::MIN
    operator = OperatorInfo.new(-1, Int32::MIN, nil, nil)
    last_size = operator.size

    operators.each do |op_info|
      op = self.operators[op_info.operator_index]
      if(op.priority > last_priority || (op.priority == last_priority && op_info.size > last_size))
        last_priority = op.priority
        last_size = op_info.size
        operator = op_info
      end
    end

    if(!operator.left_value && !operator.right_value && operator.size == Int32::MIN)
      return nil
    else
      return operator
    end
  end
end
