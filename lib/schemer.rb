require 'polyglot'
require 'treetop'

module Schemer
  class RuntimeError < StandardError; end
  class ParseError < StandardError; end

  PARSER = Treetop.load('schemer').new

  class << self
    def parse(string)
      tree = PARSER.parse(string)
      if tree.nil?
        raise ParseError, "Parse error at offset: #{PARSER.index}"
      end
      tree
    end

    def run(string)
      ast = parse(string).to_ast
      ast.map(&:run)
    end
  end
end

require_relative 'schemer/expression'
require_relative 'schemer/atom'
require_relative 'schemer/list'
require_relative 'schemer/function'
