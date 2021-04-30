require "./*"

class OperatorManager
  @@operators = [Add, Sub, Multiplied, Division]

  def self.operators
    return @@operators
  end

  #search a class in operators from the symbol
  #return the class and you allow create the instance of that class by method chain.
  def self.operator_factory(symbol : String) : Class
    OperatorManager.operators.each do |op|
      if(symbol == op.symbol)
        return op
      end
    end

    return Nil
  end

  def self.create_formula(formula : String) : Operator?
    matchs = [] of Hash(String, Int32 | String)
    OperatorManager.operators.each_with_index do |op, i|
      if(values = self.search_operator(op, i, formula))
        matchs << values
      end
    end
    op_info = self.operators_select(matchs)
    if(op_info)
      index = op_info["operator_index"]
      left_value = op_info["left"]
      right_value = op_info["right"]
      if(index.is_a?(Int32) && left_value.is_a?(String) && right_value.is_a?(String))
        return self.operators[index].new(Literal.new(left_value), Literal.new(right_value))
      end
    end
    return nil
  end

  def self.search_operator(op : Class, op_index : Int32, formula : String)
    symbol = Regex.escape(op.symbol)
    pattern = Regex.new("(.*)(#{symbol})(.*)")
    md = pattern.match(formula)
    if(md)
      return {"left"=>md[1], "right"=>md[3], "size"=>md[1].size, "operator_index"=>op_index}
    else
      return nil
    end
  end

  def self.operators_select(operators : Array) : Hash(String, Int32 | String) | Hash(String, Int32) | Nil
    last_priority = Int32::MAX
    operator = {"size"=>Int32::MAX}
    last_size = operator["size"]

    operators.each do |op_info|
      if((index = op_info["operator_index"]).is_a?(Int32))
        op = self.operators[index]
      else
        next
      end

      if(last_size.is_a?(Int32) && (size = op_info["size"]).is_a?(Int32))

        if(op.priority < last_priority || (op.priority == last_priority &&size < last_size))
          last_priority = op.priority
          last_size = size
          operator = op_info
        end
      end
    end

    if(!operator["left"]? && !operator["right"]? && operator["size"] == Int32::MAX)
      return nil
    else
      return operator
    end
  end
end
