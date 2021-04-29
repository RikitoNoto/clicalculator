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
    OperatorManager.operators.each do |op|
      if(values = self.search_operator(op.symbol, formula))
        return op.new(Literal.new(values[0]), Literal.new(values[1]))
      end
    end
    return nil
  end

  def self.search_operator(symbol : String, formula : String)
    symbol = Regex.escape(symbol)
    pattern = Regex.new("(.*)(#{symbol})(.*)")
    md = pattern.match(formula)
    if(md)
      return {md[1], md[3]}
    else
      return nil
    end
  end
end
