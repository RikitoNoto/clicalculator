require "./spec_helper"

describe Operator do

  describe "initialize" do
    it "should be able to initialize Add class." do
      plus = Add.new(Literal.new("123"),Literal.new("243"))

      plus.left_value.should eq "123"
      plus.right_value.should eq "243"
    end

    it "should be able to initialize Sub class." do
      minus = Sub.new(Literal.new("123"),Literal.new("243"))

      minus.left_value.should eq "123"
      minus.right_value.should eq "243"
    end

    it "should be able to initialize Multiplied class." do
      multiplied = Multiplied.new(Literal.new("123"),Literal.new("243"))

      multiplied.left_value.should eq "123"
      multiplied.right_value.should eq "243"
    end

    it "should be able to initialize Division class." do
      division = Division.new(Literal.new("123"),Literal.new("243"))

      division.left_value.should eq "123"
      division.right_value.should eq "243"
    end
  end

  describe "factory select" do
    it "should be have the subclass infomation of Add." do
      OperatorManager.operator_factory("+").should eq Add
    end

    it "should be have the subclass infomation of Sub." do
      OperatorManager.operator_factory("-").should eq Sub
    end

    it "should be have the subclass infomation of Multiplied." do
      OperatorManager.operator_factory("*").should eq Multiplied
    end

    it "should be have the subclass infomation of Division." do
      OperatorManager.operator_factory("/").should eq Division
    end

    it "should be have no the subclass infomation of invalid class." do
      OperatorManager.operator_factory("none").should eq Nil
    end
  end

  describe "creating operators" do
    it "should be create the simple addition formula" do
      operator = OperatorManager.create_formula("123+12")
      operator.should be_a(Add)
      if(operator.is_a?(Operator))
        operator.left_value.should eq "123"
        operator.right_value.should eq "12"
      end
    end

    it "should be create the simple subtraction formula" do
      operator = OperatorManager.create_formula("153-112")
      operator.should be_a(Sub)
      if(operator.is_a?(Operator))
        operator.left_value.should eq "153"
        operator.right_value.should eq "112"
      end
    end
  end
end
