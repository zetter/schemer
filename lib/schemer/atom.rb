class Schemer::Atom < Schemer::Expression
  def children
    @children.first
  end

  def run
    self
  end
end