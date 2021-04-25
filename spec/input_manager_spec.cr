require "./spec_helper"

describe InputManager do
  # TODO: Write tests

  describe "formula" do
    it "should be inputs become one input." do
      inputs = ["pa", "thed", " a ", "te", "st."]
      input = InputManager.new(inputs)
      input.formula.should eq "pathed a test."
    end

    it "should be inputs become one input." do
      inputs = ["pa", "thed", " a ", "te", "st2."]
      input = InputManager.new(inputs)
      input.formula.should eq "pathed a test2."
    end

    it "should be inputs are a simble or a number." do
      expect_raises(Exception, "invalid formula.") do
        inputs = ["do", "not", "path", "test"]
        input = InputManager.new(inputs)
      end
    end
  end
end
