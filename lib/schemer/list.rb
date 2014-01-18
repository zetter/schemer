class Schemer::List < Schemer::Expression
  def run
    @children = children.map(&:run)

    if function == Schemer::Atom.new('car')
      arg = arguments.first
      unless arg.is_a? Schemer::List
        raise Schemer::RuntimeError.new('arg for car must be a list')
      end
      if arg.empty?
        raise Schemer::RuntimeError.new('arg for car cannot be an empty list')
      end
      arg.children[0]
    elsif function == Schemer::Atom.new('cdr')
      arg = arguments.first
      unless arg.is_a? Schemer::List
        raise Schemer::RuntimeError.new('arg for cdr must be a list')
      end
      if arg.empty?
        raise Schemer::RuntimeError.new('arg for cdr cannot be an empty list')
      end
      Schemer::List.new(*arg.children.drop(1))
    elsif function == Schemer::Atom.new('cons')
      expression = arguments[0]
      list = arguments[1]
      unless list.is_a? Schemer::List
        raise Schemer::RuntimeError.new('second arg for cons must be a list')
      end
      Schemer::List.new(*list.children.unshift(expression))
    else
      self
    end
  end

  def arguments
    children.drop(1)
  end

  def function
    children[0]
  end

  def empty?
    children.empty?
  end

  def to_s
    "(#{children.join(' ')})"
  end
end