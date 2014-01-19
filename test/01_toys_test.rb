require_relative 'test_helper'

describe '1. Toys' do
  i_suck_and_my_tests_are_order_dependent!

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

  it 'can use car to get the first expression in a list' do
    assert_equal_after_running 'a', '(car (a b c))'
    assert_equal_after_running '(a b c)', '(car ((a b c), x, y z))'
  end

  specify 'car is only defined for non-empty lists' do
    assert_no_answer '(car hotdog)'
    assert_no_answer '(car ())'
  end

  it 'can use car on nested lists' do
    assert_equal_after_running '((hotdogs))', '(car (((hotdogs)) (and) (pickle) relish))'
  end

  it 'runs nested car functions' do
    assert_equal_after_running '(hotdogs)', '(car (car (((hotdogs)) (and)) ))'
  end

  it 'can use cdr to get the tail of a list' do
    assert_equal_after_running '(b c)', '(cdr (a b c))'
    assert_equal_after_running '(x y z)', '(cdr ((a b c) x y z))'
    assert_equal_after_running '()', '(cdr (hamburger))'
    assert_equal_after_running '(t r)', '(cdr ((x) t r))'
  end

  specify 'cdr is only defined for non empty lists' do
    assert_no_answer '(cdr hotdogs)'
    assert_no_answer '(cdr ())'
  end

  it 'can use combinations of car and cdr' do
    assert_equal_after_running '(x y)', '(car (cdr ((b) (x y) ((c)))))'
    assert_equal_after_running '(((c)))', '(cdr (cdr ((b) (x y) ((c)))))'
    assert_no_answer '(cdr (car (a (b (c)) d)))'
  end

  it 'can use cons to combine two lists' do
    assert_equal_after_running '(peanut butter and jelly)', '(cons peanut (butter and jelly))'
    assert_equal_after_running '((banana and) peanut butter and jelly)', '(cons (banana and) (peanut butter and jelly))'
    assert_equal_after_running '(((help) this) is very ((hard) to learn))', '(cons ((help) this) (is very ((hard) to learn)))'
    assert_equal_after_running '((a b (c)))', '(cons (a b (c)) ())'
    assert_equal_after_running '(a)', '(cons a ())'
  end

  specify 'cons is only defined when the second argument is a list' do
    assert_no_answer '(cons ((a b c)) b)'
    assert_no_answer '(cons a b)'
  end

  it 'can use combinations of cons, car and cdr' do
    assert_equal_after_running '(a b)', '(cons a (car ((b) c d)))'
    assert_equal_after_running '(a c d)', '(cons a (cdr ((b) c d)))'
  end

  it 'can use null? to check for empty lists' do
    assert_equal_after_running '#t', '(null? ())'
    assert_equal_after_running '#t', '(null? (quote ()))'
    assert_equal_after_running '#f', '(null? (a b c))'
  end

  specify 'null is only defined for lists' do
    assert_no_answer '(null? spaghetti)'
  end

  it 'can use atom? to check for atoms' do
    assert_equal_after_running '#t', '(atom? Harry)'
    assert_equal_after_running '#f', '(atom? (Harry had a heap of apples))'
  end

  it 'can use atom? with car and cdr' do
    assert_equal_after_running '#t', '(atom? (car (Harry had a heap of apples)))'
    assert_equal_after_running '#f', '(atom? (cdr (Harry had a heap of apples)))'
    assert_equal_after_running '#f', '(atom? (cdr (Harry)))'
    assert_equal_after_running '#t', '(atom? (car (cdr (swing low sweet cheery oat))))'
    assert_equal_after_running '#f', '(atom? (car (cdr (swing (low sweet) cheery oat))))'
  end

  it 'can use eq? to find if two atoms are equal' do
    assert_equal_after_running '#t', '(eq? Harry Harry)'
    assert_equal_after_running '#f', '(eq? margarine butter)'
  end

  specify 'eq? is only defined for non numeric atoms' do
    assert_no_answer '(eq? () (stawberry))'
    assert_no_answer '(eq? 6 7)'
  end

  it 'can use eq with combinations of car and cdr' do
    assert_equal_after_running '#t', '(eq? (car (Mary had a little lamb chop)) Mary)'
    assert_no_answer '(eq? (cdr (soured milk)) milk)'
    assert_equal_after_running '#t', '(eq? (car (beans beans beans we need jelly beans)) (car (cdr (beans beans beans we need jelly beans)) ))'
  end
end