require 'bundler/setup'

require 'minitest'
require 'minitest/autorun'

require File.expand_path './../../lib/schemer', __FILE__

module SchemerHelpers
  def parse(code)
    begin
      result = Schemer::Parser.parse(code)
    rescue Schemer::Parser::ParseError => exception
      raise Minitest::Assertion, "Parsing '#{code}' failed with #{exception.message}"
    end
    result
  end
end


module MiniTest::Assertions
  def assert_parses_to_kind_of(klass, code)
    assert_kind_of klass, parse(code), "Parsing '#{code}'"
    true
  end
end
