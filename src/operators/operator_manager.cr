require "./*"

class OperatorManager
  @@operators = {Add, Sub, Multiplied, Division}

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
end
