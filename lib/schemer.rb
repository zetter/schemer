require 'polyglot'
require 'treetop'

module Schemer
  class Runner
    class RuntimeError < StandardError; end

    def initialize(ast)
      @ast = ast
    end

    def run
      @ast.map{|expression| run_expression(expression)}
    end

    def run_expression(expression)
      if expression.children[0] == Schemer::Atom.new('car')
        arg = expression.children[1]
        unless arg.is_a? Schemer::List
          raise RuntimeError.new('arg for car must be a list')
        end
        if arg.children == []
          raise RuntimeError.new('arg for car cannot be an empty list')
        end
        result = arg.children[0]
        result
      else
        self
      end
    end
  end
end

require_relative 'schemer/parser'
require_relative 'schemer/expression'
require_relative 'schemer/atom'
require_relative 'schemer/list'
