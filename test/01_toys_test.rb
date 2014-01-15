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
    assert_equal 2, ast.children.length
    assert_kind_of(Schemer::Expression, ast.children.first)
    assert_kind_of(Schemer::List, ast.children.first)
    assert_kind_of(Schemer::Expression, ast.children.last)
    assert_kind_of(Schemer::Atom, ast.children.last)
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
    elements = ast.children.first.child.children
    assert_equal 6, elements.length
    assert_equal Schemer::Atom.new('how'), elements[0]
    assert_equal Schemer::Atom.new('are'), elements[1]
    assert_equal Schemer::Atom.new('you'), elements[2]
    assert_equal Schemer::Atom.new('doing'), elements[3]
    assert_equal Schemer::Atom.new('so'), elements[4]
    assert_equal Schemer::Atom.new('far'), elements[5]
  end

  it 'parses lists in lists in lists' do
    code = '(((how) are) ((you) (doing so)) far)'
    assert_parses_to_kind_of(Schemer::List, code)

    elements = ast_for(code).children.first.child.children
    assert_equal 3, elements.length
    assert_equal ['((how) are)', '((you) (doing so))', 'far'], elements.map(&:to_s)
  end

  it 'parses empty lists' do
    assert_parses_to_kind_of(Schemer::List, '()')
    refute_kind_of(Schemer::Atom, ast_for('()').first)
    assert_parses_to_kind_of(Schemer::List, '(() () () ())')
  end

end