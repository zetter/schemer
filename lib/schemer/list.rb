class Schemer::List < Schemer::Expression
  def to_s
    "(#{child.to_s})"
  end

end