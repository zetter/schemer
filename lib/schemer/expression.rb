class Schemer::Expression
  attr_reader :child

  def initialize(child)
    @child = child
  end

  def ==(other_expression)
    self.child == other_expression.child
  end

  def to_s
    child.to_s
  end
end