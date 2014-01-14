require_relative 'test_helper'

describe '1. Toys' do
  it 'parses atoms' do
    assert_parses_to_kind_of(Schemer::Atom, 'atom')
    assert_parses_to_kind_of(Schemer::Atom, 'turkey')
    assert_parses_to_kind_of(Schemer::Atom, '1492')
    assert_parses_to_kind_of(Schemer::Atom, 'u')
    assert_parses_to_kind_of(Schemer::Atom, '*abc$')
  end

  it 'parses lists' do
    assert_parses_to_kind_of(Schemer::List, '(atom)')
    assert_parses_to_kind_of(Schemer::List, '(atom turkey or)')
  end
end