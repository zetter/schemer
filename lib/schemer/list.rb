module Schemer
  class List < Expression
    def run
      @children = children.map(&:run)

      if function == Atom.new('car')
        arg = arguments.first
        unless arg.is_a? List
          raise RuntimeError.new('arg for car must be a list')
        end
        if arg.empty?
          raise RuntimeError.new('arg for car cannot be an empty list')
        end
        arg.children[0]
      elsif function == Atom.new('cdr')
        arg = arguments.first
        unless arg.is_a? List
          raise RuntimeError.new('arg for cdr must be a list')
        end
        if arg.empty?
          raise RuntimeError.new('arg for cdr cannot be an empty list')
        end
        List.new(*arg.children.drop(1))
      elsif function == Atom.new('cons')
        expression = arguments[0]
        list = arguments[1]
        unless list.is_a? List
          raise RuntimeError.new('second arg for cons must be a list')
        end
        List.new(*list.children.unshift(expression))
      elsif function == Atom.new('null?')
        arg = arguments.first
        unless arg.is_a? List
          raise RuntimeError.new('arg for cdr must be a list')
        end
        if arg == List.new
          Atom.new('#t')
        else
          Atom.new('#f')
        end
      elsif function == Atom.new('quote')
        List.new
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
end