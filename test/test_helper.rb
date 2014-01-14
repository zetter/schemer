require 'bundler/setup'

require 'minitest'
require 'minitest/autorun'

require File.expand_path './../../lib/schemer', __FILE__

module MiniTest::Assertions
  def assert_parses_to_kind_of(klass, code)
    result = Schemer::Parser.parse(code)
    message = "Parsing '#{code}'"
    assert_kind_of klass, result, message
    true
  end
end
