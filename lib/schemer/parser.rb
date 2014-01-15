require 'treetop'

class Schemer::Parser
  class ParseError < StandardError; end

  def self.parse(string)
    parser = Treetop.load('schemer').new
    tree = parser.parse(string)
    if tree.nil?
      raise ParseError, "Parse error at offset: #{parser.index}"
    end
    tree
  end
end
