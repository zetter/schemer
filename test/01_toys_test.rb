require_relative 'test_helper'

describe '1. Toys' do
  it 'parses atoms' do
    assert_parses_to_kind_of(Schemer::Atom, 'atom')
    assert_parses_to_kind_of(Schemer::Atom, 'turkey')
    assert_parses_to_kind_of(Schemer::Atom, '1492')
    assert_parses_to_kind_of(Schemer::Atom, 'u')
    assert_parses_to_kind_of(Schemer::Atom, '*abc$')
  end

  it 'parses lists and expressions' do
    assert_parses_to_kind_of(Schemer::List, '(atom)')
    assert_parses_to_kind_of(Schemer::List, '(atom turkey or)')
    assert_parses_to_kind_of(Schemer::Expression, '(atom turkey) or')
    assert_parses_to_kind_of(Schemer::List, '((atom turkey) or)')
    assert_parses_to_kind_of(Schemer::Expression, 'xyz')
    assert_parses_to_kind_of(Schemer::Expression, '(x y z)')
    assert_parses_to_kind_of(Schemer::Expression, '((x y) z)')
    assert_parses_to_kind_of(Schemer::Expression, '(how are you doing so far)')
  end
end