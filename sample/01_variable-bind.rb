def var_bind(val)
  case val
    in [0, a]
    [:zero, a]
    in [-1..1, b]
    [:range, b]
    in [Integer, c]
    [:class, c]
  else
    :nothing
  end
end

p var_bind([0, true])
p var_bind([1, true])
p var_bind([-1, true])
p var_bind([100000, true])
p var_bind(["1", true])
p var_bind([0, nil])
p var_bind([0, {}])
p var_bind([0, Exception])
