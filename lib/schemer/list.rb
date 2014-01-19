module Schemer
  class List < Expression
    def run
      @children = children.map(&:run)

      if function == Atom.new('car')
        raise RuntimeError.new('arg for car must be a non-empty list') if !arg.list? || arg.empty?
        arg.children[0]
      elsif function == Atom.new('cdr')
        raise RuntimeError.new('arg for cdr must be a non-empty list') if !arg.list? || arg.empty?
        List.new(*arg.children.drop(1))
      elsif function == Atom.new('cons')
        raise RuntimeError.new('second arg for cons must be a list') unless arg_2.list?
        List.new(*arg_2.children.unshift(arg_1))
      elsif function == Atom.new('null?')
        raise RuntimeError.new('arg for cdr must be a list') unless arg.list?
        to_true_or_false(arg == List.new)
      elsif function == Atom.new('quote')
        List.new
      elsif function == Atom.new('atom?')
         to_true_or_false(arg.atom?)
      elsif function == Atom.new('eq?')
        unless arg_1.atom? && arg_2.atom? && arg_1.non_numeric? && arg_2.non_numeric?
          raise RuntimeError.new('args for eql must non-numeric atoms')
        end
        to_true_or_false(arg_1 == arg_2)
      else
        self
      end
    end

    def list?
      true
    end

    def arguments
      children.drop(1)
    end

    def arg_1
      arguments[0]
    end
    alias :arg :arg_1

    def arg_2
      arguments[1]
    end

    def function
      children[0]
    end

    def to_true_or_false(boolean)
      if boolean
        Atom.new('#t')
      else
        Atom.new('#f')
      end
    end

    def empty?
      children.empty?
    end

    def to_s
      "(#{children.join(' ')})"
    end
  end
end