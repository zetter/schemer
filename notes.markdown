# notes

## 1. Toys

page 3
Is it really true that an atom is just not '(' or ')'?
I'm guess whitespace is inferred (parser just handling spaces for now).

page 4
For '(atom turkey) or' I chose to make every code a list of expressions, i.e.
'abc' is not an atom, it's an expression list containing a
single atom.

page 5
I wasn't sure about the right way to write the 'car' examples in scheme,
I was failing in to do it in racket. Some research showed me you have
to use a single quote (') to allow unbound variables in other
schemes- i.e. (car '(a)). Not sure if there is a reason the book says
'what is the x of y where y is ...'.

There's also an online interpreter http://repl.it/ this works in.