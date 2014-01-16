require 'polyglot'
require 'treetop'

module Schemer
  class Runner
    def initialize(ast)
      @ast = ast
    end

    def run
      @ast.map{|expression| run_expression(expression)}
    end

    def run_expression(expression)
      if expression.children[0] == Schemer::Atom.new('car')
        arg = expression.children[1]
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
