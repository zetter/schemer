module Schemer
  class Atom < Expression
    def children
      @children.first
    end

    def run
      self
    end

    def non_numeric?
      !(children =~ /^\d*$/)
    end
  end
end