require_relative 'test_helper'

describe '1. Toys' do
  include SchemerHelpers

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

    ast = ast_for('(atom turkey) or')
    assert_equal 2, ast.children.length
    assert_kind_of(Schemer::Expression, ast.children.first)
    assert_kind_of(Schemer::List, ast.children.first)
    assert_kind_of(Schemer::Expression, ast.children.last)
    assert_kind_of(Schemer::Atom, ast.children.last)

    assert_parses_to_kind_of(Schemer::List, '((atom turkey) or)')
    assert_parses_to_kind_of(Schemer::Expression, 'xyz')
    assert_parses_to_kind_of(Schemer::Expression, '(x y z)')
    assert_parses_to_kind_of(Schemer::Expression, '((x y) z)')
    assert_parses_to_kind_of(Schemer::Expression, '(how are you doing so far)')
  end
end