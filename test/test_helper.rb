require 'bundler/setup'

require 'minitest'
require 'minitest/autorun'

require File.expand_path './../../lib/schemer', __FILE__

module MiniTest::Assertions
  def assert_parses_to_kind_of(klass, code)

    begin
      result = Schemer::Parser.parse(code)
    rescue Exception => exception
      raise Minitest::Assertion, "Parsing '#{code}' failed with #{exception.message}"
    end

    assert_kind_of klass, result, "Parsing '#{code}'"
    true
  end
end
