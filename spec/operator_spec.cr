require "./spec_helper"

describe Operator do

  describe "initialize" do
    it "should be able to initialize Add class." do
      operator_initialize_test(Add, "123", "243")
    end

    it "should be able to initialize Sub class." do
      operator_initialize_test(Sub, "342", "435")
    end

    it "should be able to initialize Multiplied class." do
      operator_initialize_test(Multiplied, "243", "9087")
    end

    it "should be able to initialize Division class." do
      operator_initialize_test(Division, "5032", "34567")
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
    it "should be create Operator from the simple addition formula" do
      operator_factory_test("123+12", "123", "12").should be_a(Add)
    end

    it "should be create Operator from the simple subtraction formula" do
      operator_factory_test("1233-132", "1233", "132").should be_a(Sub)
    end

    it "should be create Operator from the simple multiplied formula" do
      operator_factory_test("155*60", "155", "60").should be_a(Multiplied)
    end

    it "should be create Operator from the formula what has two operators." do
      operator_factory_test("100*39+1", "100", "39+1").should be_a(Multiplied)
    end
  end
end
