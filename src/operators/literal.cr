class Literal
    @value : String
    getter value

    def initialize(value : String?)
      @value = value ? value : ""
    end
end
