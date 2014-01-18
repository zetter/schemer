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
  end

  it 'parses multiple expressions' do
    ast = ast_for('(atom turkey) or')
    assert_equal 2, ast.length
    expected = [list(atom('atom'), atom('turkey')), atom('or')]
    assert_equal expected, ast
  end

  it 'parses lists in lists' do
    assert_parses_to_kind_of(Schemer::List, '((atom turkey) or)')
  end

  specify 'lists and atoms are expressions' do
    assert_parses_to_kind_of(Schemer::Expression, 'xyz')
    assert_parses_to_kind_of(Schemer::Expression, '(x y z)')
    assert_parses_to_kind_of(Schemer::Expression, '((x y) z)')
    assert_parses_to_kind_of(Schemer::Expression, '(how are you doing so far)')
  end

  it 'parses expressions within lists' do
    ast = ast_for('(how are you doing so far)')
    assert_equal 6, ast.first.children.length
    expected = list(
      atom('how'),
      atom('are'),
      atom('you'),
      atom('doing'),
      atom('so'),
      atom('far')
    )
    assert_equal [expected], ast
  end

  it 'parses lists in lists in lists' do
    code = '(((how) are) ((you) (doing so)) far)'
    assert_parses_to_kind_of(Schemer::List, code)

    ast = ast_for(code)
    assert_equal 3, ast.first.children.length

    expected = list(
      list(list(atom('how')), atom('are')),
      list(list(atom('you')), list(atom('doing'), atom('so'))),
      atom('far')
    )
    assert_equal [expected], ast
  end

  it 'parses empty lists' do
    assert_parses_to_kind_of(Schemer::List, '()')
    refute_kind_of(Schemer::Atom, ast_for('()').first)
    assert_parses_to_kind_of(Schemer::List, '(() () () ())')
  end

end