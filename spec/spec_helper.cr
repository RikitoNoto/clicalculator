require "spec"
require "../src/clicalculator"
require "../src/operators/operator_manager"

def operator_values_check(instance : Operator?, left_value : String, right_value : String)
  if(instance.is_a?(Operator))
    instance.left_value.should eq left_value
    instance.right_value.should eq right_value
  else
    fail "Don't given the instance of Operator class."
  end
end

def operator_initialize_test(klass : Class, left_value : String, right_value : String)
  instance = klass.new(Literal.new(left_value),Literal.new(right_value))

  operator_values_check(instance, left_value, right_value)
end

def operator_factory_test(formula : String, left_value : String, right_value : String)
  instance = OperatorManager.create_formula(formula)
  operator_values_check(instance, left_value, right_value)
  return instance
end
