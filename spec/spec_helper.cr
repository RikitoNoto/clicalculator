require "spec"
require "../src/clicalculator"
require "../src/operators/operator_manager"

def operator_values_check(instance : Operator?, left_formula : String, right_formula : String)
  if(instance.is_a?(Operator))
    instance.left_formula.should eq left_formula
    instance.right_formula.should eq right_formula
  else
    fail "Don't given the instance of Operator class."
  end
end

def operator_initialize_test(klass : Class, left_formula : String, right_formula : String)
  instance = klass.new(Literal.new(left_formula),Literal.new(right_formula))

  operator_values_check(instance, left_formula, right_formula)
end

def operator_factory_test(formula : String, left_formula : String, right_formula : String)
  instance = OperatorManager.create_formula(formula)
  operator_values_check(instance, left_formula, right_formula)
  return instance
end
