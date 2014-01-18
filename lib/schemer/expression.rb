class Schemer::Expression
  attr_reader :children

  def initialize(*children)
    @children = children
  end

  def ==(other_expression)
    self.children == other_expression.children
  end

  def to_s
    children.to_s
  end
end