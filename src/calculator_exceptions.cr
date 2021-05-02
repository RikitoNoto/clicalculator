class CalculatorExceptions

    #if could not create operators from the receive formula,
    #this class raise this exception.
    class InvalidFormulaException < Exception
    end

    #do not expected exception
    class DontExpectedException < Exception
    end
end