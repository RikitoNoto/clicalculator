require "./spec_helper"

describe Operator do

  describe "initialize" do
    it "should be search itself from the string." do
      plus = Plus.new("123+243")

      plus.left_value.should eq "123"
      plus.right_value.should eq "243"
    end
  end
end
