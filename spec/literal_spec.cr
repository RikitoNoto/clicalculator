require "./spec_helper"

describe Literal do
  # TODO: Write tests

  describe "initialize" do
    it "should be able to initialize." do
      literal = Literal.new("1243*3254")
      literal.value.should eq "1243*3254"
    end
  end
end
