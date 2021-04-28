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

  describe "factory" do
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
end
