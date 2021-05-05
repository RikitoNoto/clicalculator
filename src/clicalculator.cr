
require "./input_manager"
require "./operators/operator_manager"
# TODO: Write documentation for `Clicalculator`
module Clicalculator
  VERSION = "0.1.0"
  class Calculator
    def self.calculate(output = STDOUT, *args, argv = Tuple.new)
      if(args.size > 0)
        output.print InputManager.new("", *args).calculate()
        output.print '\n'
      elsif(argv.size > 0)
        output.print InputManager.new("", argv: argv).calculate()
        output.print '\n'
      end      
    end
  end
end
