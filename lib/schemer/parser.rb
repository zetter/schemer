require 'treetop'

class Schemer::Parser
  class ParseError < StandardError; end

  PARSER = Treetop.load('schemer').new

  def self.parse(string)
    tree = PARSER.parse(string)
    if tree.nil?
      raise ParseError, "Parse error at offset: #{parser.index}"
    end
    tree
  end
end
