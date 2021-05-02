require "./*"
require "../calculator_exceptions"

# This class allow you create operators from the formula.
# This class never create as instance,
# because all its methods are class methods.
class OperatorManager

  # all operators that this class management.
  @@operators = [Add, Sub, Multiplied, Division, Parenthese]

  private def self.operators
    return @@operators
  end

  # the struct is used when OperatorManager exchange the operator infomations in between the methods.
  private struct OperatorInfo
    property operator_index, size, left_formula, right_formula, priority
    @left_formula : String?
    @right_formula : String?
    def initialize(@operator_index = -1, @size = Int32::MIN, @left_formula = nil, @right_formula = nil, @priority = Int32::MIN)
    end
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
  def self.create_formula(formula : String) : Operator
    matchs = [] of OperatorInfo
    self.operators.each_with_index do |op, i|
      if(values = self.search_operator(op, i, formula))
        matchs << values
      end
    end
    op_info = self.operators_select(matchs)
    if(op_info)
      return self.operators[op_info.operator_index].new(Literal.new(op_info.left_formula), Literal.new(op_info.right_formula))
    end
    raise CalculatorExceptions::InvalidFormulaException.new("invalid formula : #{formula}")
  end

  # search a operator from the received formula and return the OperatorInfo.
  # if the formula has no the received operator, this method return nil.
  # ###params
  # op: A class what inherited Operator class
  # op_index: the index of op in class member operators.
  # formula: the formula what search in.
  private def self.search_operator(op : Class, op_index : Int32, formula : String) : OperatorInfo?
    md = op.search(formula)
    if(md)
      return OperatorInfo.new(op_index, md.size, md.left_formula, md.right_formula, op.priority)
    else
      return nil
    end
  end


  # select a operator in operators array.
  # Selection condition is 
  # ・the priority of the operator is highest.
  # ・the operator is exist in most left.
  # ・the operator is not in parenthese.
  # ###params
  # operators: the array of OperatorInfo. this method return one of these.
  private def self.operators_select(operators : Array) : OperatorInfo?
    last_operator = OperatorInfo.new()

    operators.each do |op_info|#OperatorInfo
      op = self.operators[op_info.operator_index]
      if(self.in_parenthese?(op_info.left_formula))
        next
      elsif(op.priority > last_operator.priority || (op.priority == last_operator.priority && op_info.size > last_operator.size))
        #the operator is selected when its priority is higher than highest priority in current or
        #its priority is same to highest priority in current and its order of appearence in the formula is faster than fastest in current.
        last_operator = op_info
      end
    end

    if(!last_operator.left_formula && !last_operator.right_formula && last_operator.size == Int32::MIN)
      return nil
    else
      return last_operator
    end
  end


  # Checks if the operator is in parentheses.
  # if not same the count of '(' and ')' in left_value,
  # then the operator is in parentheses.
  # if the left_value is nil then judge the operator is not in parentheses.
  # ###params
  # left_value: on the left value of the operator.
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
