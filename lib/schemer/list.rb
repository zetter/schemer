module Schemer
  class List < Expression
    def run
      run_children = children.map(&:run)
      Function.new(run_children).execute
    end

    def list?
      true
    end

    def empty?
      children.empty?
    end

    def to_s
      "(#{children.join(' ')})"
    end
  end
end