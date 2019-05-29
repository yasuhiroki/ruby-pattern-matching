def var_pin(val)
  a = 0
  case val
    in ^a
      [:zero, a]
  else
    :nothing
  end
end

p var_pin(0)
p var_pin(1)
