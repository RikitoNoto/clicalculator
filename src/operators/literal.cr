require "../calculator_exceptions"
class Literal
    @formula: String
    @operator : Operator?
    @value : Int32 | Float64 | Nil
    getter formula, operator

    def initialize(formula : String?)
      @formula= formula ? formula : ""
      self.create_operator
    end

    def create_operator
      if( @formula == "" )
        @operator = nil
      else
        begin
          @operator = OperatorManager.create_formula(@formula)
        rescue CalculatorExceptions::InvalidFormulaException
          @operator = nil
          self.to_num
        end
      end
    end

    def to_num : Int32 | Float64
      if(/\d*\./.match(@formula))
        begin
          @value = @formula.to_f
        rescue
          raise CalculatorExceptions::InvalidFormulaException.new("could not understand formula: #{@formula}")
        end
      elsif(/\d*/.match(@formula))
        begin
          @value = @formula.to_i
        rescue
          raise CalculatorExceptions::InvalidFormulaException.new("could not understand formula: #{@formula}")
        end
      else
        raise CalculatorExceptions::DontExpectedException.new("do not expected exception.")
      end
    end

    def value
      value = @value
      operator = @operator

      if(value)
        return value
      elsif(operator)
        return operator.calculate
      else
        raise CalculatorExceptions::DontExpectedException.new("do not expected exception.")
      end
    end
end
