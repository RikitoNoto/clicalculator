class Literal
    @formula: String
    @operator : Operator?
    getter formula, operator

    def initialize(formula : String?)
      @formula= formula ? formula : ""
      self.create_operator
    end

    def create_operator
      begin
        @operator = OperatorManager.create_formula(@formula)
      rescue
        @operator = nil
      end
    end
end
