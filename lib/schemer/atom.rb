module Schemer
  class Atom < Expression
    def children
      @children.first
    end

    def run
      self
    end
  end
end