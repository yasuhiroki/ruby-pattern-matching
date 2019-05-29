def var(val)
  a = 0
  b = -1..1
  c = Integer
  case val
    in a
    :zero
    in b
    :range
    in c
    :class
  else
    :nothing
  end
end

p var(0)
p var(1)
p var(-1)
p var(100000)
p var("1")
