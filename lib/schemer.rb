require 'polyglot'
require 'treetop'

module Schemer
  class RuntimeError < StandardError; end

  class Runner

    def initialize(ast)
      @ast = ast
    end

    def run
      @ast.map(&:run)
    end
  end
end

require_relative 'schemer/parser'
require_relative 'schemer/expression'
require_relative 'schemer/atom'
require_relative 'schemer/list'
