class Schemer::List < Schemer::Expression
  def run
    @children = children.map(&:run)

    if children[0] == Schemer::Atom.new('car')
      arg = children[1]
      unless arg.is_a? Schemer::List
        raise Schemer::RuntimeError.new('arg for car must be a list')
      end
      if arg.children == []
        raise Schemer::RuntimeError.new('arg for car cannot be an empty list')
      end
      result = arg.children[0]
      result
    else
      self
    end
  end

  def to_s
    "(#{children.join(' ')})"
  end
end