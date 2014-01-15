class Schemer::Expressions
  attr_reader :children

  def initialize(children)
    @children = children
  end

  def length
    @children.length
  end

  def first
    @children.first
  end

  def to_s
    @children.join(' ')
  end
end