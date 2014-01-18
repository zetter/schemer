class Schemer::List < Schemer::Expression
  def to_s
    "(#{children.join(' ')})"
  end
end