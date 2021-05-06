require "./spec_helper"
require "./input_manager_spec"
require "./literal_spec"
require "./operator_spec"
require "../src/clicalculator"

describe Clicalculator do
  # TODO: Write tests
  it "should be output result to the standard output." do
    io = IO::Memory.new
    Clicalculator::Calculator.calculate(io, "1+1")
    io.to_s.should eq "2\n"
  end
end
