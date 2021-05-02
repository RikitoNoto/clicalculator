abstract class Operator
  @@symbol = ""
  @@priority = Int32::MIN

  struct SearchResult
    property left_formula, right_formula, symbol, size
    def initialize(@left_formula : String?, @right_formula : String?, @symbol : String, @size : Int32)
    end
  end

  def initialize(@left : Literal, @right : Literal)
  end

  def self.symbol
    return @@symbol
  end

  def self.priority
    return @@priority
  end

  def self.search(formula : String) : SearchResult?
    md = self.pattern.match(formula)
    if(md)
      return SearchResult.new(md[1], md[3], md[2], md[1].size)
    end
    return nil
  end

  private def self.pattern
    symbol = Regex.escape(self.symbol)
    pattern = Regex.new("(.*)(#{symbol})(.*)")
  end

  def left_formula : String
    @left.formula
  end

  def right_formula : String
    @right.formula
  end

  def left_operator : Operator?
    @left.operator
  end

  def right_operator : Operator?
    @right.operator
  end


  abstract def calculate

end
