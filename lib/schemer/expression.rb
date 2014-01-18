class Schemer::Expression
  attr_reader :children

  def initialize(*children)
    @children = Array(children)
  end

  def ==(other_expression)
    self.children == other_expression.children
  end

  def to_s
    children.to_s
  end

  def inspect
    "<#{self.class.to_s} children=#{@children.inspect}>"
  end
end