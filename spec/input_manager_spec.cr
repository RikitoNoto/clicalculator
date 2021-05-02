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

    it "should be inputs become no space." do
      inputs = "5 + 5"
      input = InputManager.new(inputs)
      input.input_formula.should eq "5+5"
    end
    
    it "should be inputs are a simble or a number." do
      inputs = "???"
      expect_raises(CalculatorExceptions::InvalidFormulaException) do
        input = InputManager.new(inputs)
      end
    end

    it "should be inputs become operators." do
      input_manager_test("123+235", "123", "235").formula.should be_a Add
    end

    it "should be inputs become operators." do
      input_manager_test("5*123+235", "5*123", "235").formula.should be_a(Add)
    end

    it "should be inputs become operators." do
      operator = input_manager_test("5*123+235", "5*123", "235").formula
      operator.should be_a Add
      operator.left_operator.should be_a Multiplied
      operator.right_operator.should be_a Nil
      left_operator = operator.left_operator
      right_operator = operator.right_operator
      if(left_operator.is_a?(Multiplied))
        left_operator.left_formula.should eq "5"
        left_operator.right_formula.should eq "123"
      end
    end
  end
end
