def hash(val)
  case val
    in {}
      :empty
    in { a: 1, b: }
      b
    in { a: 1 }
      :a
  else
      :else
  end
end

p hash({})              # => :empty
p hash({a: 1})          # => :a
p hash({a: 1, b: :one}) # => :one
p hash({a: 2})          # => :else

