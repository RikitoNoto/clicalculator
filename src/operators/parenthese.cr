require "./operator"
class Parenthese < Operator
  @@symbol = "()"
  @@priority = Int32::MAX


  def self.search(formula : String) : SearchResult?
    md = self.pattern.match(formula)
    if(md)
      return SearchResult.new(md[1], nil, self.symbol, Int32::MAX)
    end
    return nil
  end

  private def self.pattern
    pattern = /^\((.*)\)$/
  end

  def calculate()
  end
end
