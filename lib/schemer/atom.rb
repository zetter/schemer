class Schemer::Atom < Schemer::Expression
  def children
    @children.first
  end
end