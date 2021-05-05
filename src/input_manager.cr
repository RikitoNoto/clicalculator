require "./operators/operator_manager"

class InputManager
    @input_formula : String
    @formula : Operator
    getter input_formula, formula

    def initialize(input : String, *args, argv = [] of String)
        inputs = concat_inputs(input, args)
        inputs = concat_inputs(inputs, argv)

        @input_formula = ""# FIXME: why do raise error when delete this line.
        @formula = Add.new(Literal.new("0"), Literal.new("0"))# FIXME: why do raise error when delete this line.
        
        @input_formula = self.delete_indents(inputs)
        @formula = OperatorManager.create_formula(@input_formula)
    end

    def calculate
        result = @formula.calculate

        if result && (result.to_f % 1.0) == 0.0
            return result.to_i
        elsif result
            return result.to_f
        else
            return nil
        end
    end
    
    private def concat_inputs(input : String, args : Tuple | Array)
        inputs = [input]
        args.each do |value|
            inputs.push(value)
        end
        return inputs.join("")
    end

    private def delete_indents(inputs : String) : String
        return inputs.gsub(" ", "").gsub("\t", "")
    end
end