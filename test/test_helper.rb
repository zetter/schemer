require 'bundler/setup'

require 'minitest'
require 'minitest/autorun'

require File.expand_path './../../lib/schemer', __FILE__

module SchemerHelpers

  def atom(identifier)
    Schemer::Atom.new(identifier)
  end

  def list(*expressions)
    Schemer::List.new(*expressions)
  end

  def parse(code)
    begin
      result = Schemer::Parser.parse(code)
    rescue Schemer::Parser::ParseError => exception
      raise Minitest::Assertion, "Parsing '#{code}' failed with #{exception.message}"
    end
    result
  end

  def run_code(code)
    Schemer::Runner.new(ast_for(code)).run
  end

  def ast_for(code)
    parse(code).to_ast
  end
end


module MiniTest::Assertions
  def assert_parses_to_kind_of(klass, code)
    expressions = ast_for(code)
    assert_equal 1, expressions.length, "Can #{code}' should only contain expression"
    assert_kind_of klass, expressions.first, "Parsing '#{code}'"
    true
  end

  def assert_equal_after_running(expected, code)
    expected_ast = ast_for(expected)

    assert_equal(expected_ast, run_code(code))
  end
end
