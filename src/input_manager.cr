require "./operators/operator_manager"

class InputManager
    @input_formula : String?
    getter input_formula, formula

    def initialize(inputs : String)
        @input_formula = inputs
        @formula = OperatorManager.create_formula(inputs)
    end

    # def initialize(inputs : Array(String))
    #     self.initialize(inputs.join(""))
    # end

end