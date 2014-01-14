require 'treetop'

class Schemer::Parser
  def self.parse(string)
    parser = Treetop.load('schemer').new
    tree = parser.parse(string)
    if tree.nil?
      raise Exception, "Parse error at offset: #{parser.index}"
    end
    tree.to_ast
  end
end
