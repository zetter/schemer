class Schemer::Expression
  attr_reader :child

  def initialize(child)
    @child = child
  end
end