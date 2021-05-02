require "./spec_helper"

describe InputManager do

  describe "formula" do
    # it "should be inputs become one input." do
    #   inputs = ["6+54", "/", "65", "0"]
    #   input = InputManager.new(inputs)
    #   input.input_formula.should eq "6+54/650"
    # end

    # it "should be inputs become one input." do
    #   inputs = ["123", "+", "235", "*", "56"]
    #   input = InputManager.new(inputs)
    #   input.input_formula.should eq "123+235*56"
    # end

    pending "should be inputs are a simble or a number." do
      expect_raises(Exception, "invalid formula.") do
        inputs = "do not path this test"
        input = InputManager.new(inputs)
      end
    end

    it "should be inputs become operators." do
      inputs = "123+235"
      input = InputManager.new(inputs)
      input.formula.should be_a Add
      input.formula.left_formula.should eq "123"
      input.formula.right_formula.should eq "235"
    end

    it "should be inputs become operators." do
      inputs = "5*123+235"
      input = InputManager.new(inputs)
      input.formula.should be_a Add
      input.formula.left_formula.should eq "5*123"
      input.formula.right_formula.should eq "235"
    end

    it "should be inputs become operators." do
      inputs = "5*123+235"
      input = InputManager.new(inputs)
      input.formula.should be_a Add
      input.formula.left_operator.should be_a Multiplied
      input.formula.right_operator.should be_a Nil
      operator = input.formula.left_operator
      if(operator.is_a?(Multiplied))
        operator.left_formula.should eq "5"
        operator.right_formula.should eq "123"
      end
    end
  end
end
