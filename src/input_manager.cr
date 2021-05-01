class InputManager
    @formula : String | Nil


    def initialize(@inputs : Array(String))
        self.create_formula
    end

    def formula
        return @formula
    end

    private def create_formula
        @formula = @inputs.join("")
    end
end