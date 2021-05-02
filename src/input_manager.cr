require "./operators/operator_manager"

class InputManager
    @input_formula : String
    @formula : Operator
    getter input_formula, formula

    def initialize(inputs : String)
        @input_formula = ""# FIXME: why do raise error when delete this line.
        @formula = Add.new(Literal.new("0"), Literal.new("0"))# FIXME: why do raise error when delete this line.
        
        @input_formula = self.delete_indents(inputs)
        @formula = OperatorManager.create_formula(@input_formula)
    end

    # def initialize(inputs : Array(String))
    #     self.initialize(inputs.join(""))
    # end

    private def delete_indents(inputs : String) : String
        return inputs.gsub(" ", "").gsub("\t", "")
    end
end