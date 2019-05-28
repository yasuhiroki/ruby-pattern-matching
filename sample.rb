def value(val)
  case val
    in 0
    :zero
    in -1..1
    :range
    in Integer
    :class
  else
    :nothing
  end
end

p "-" * 10
p value(0)      # => zero
p value(1)      # => range
p value(-1)     # => range
p value(100000) # => class
p value("1")    # => nothing

def var1(val)
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

p "-" * 10
p var1(0)
p var1(1)
p var1(-1)
p var1(100000)
p var1("1")

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

p "-" * 10
p var_bind([0, true])
p var_bind([1, true])
p var_bind([-1, true])
p var_bind([100000, true])
p var_bind(["1", true])
p var_bind([0, nil])
p var_bind([0, {}])
p var_bind([0, Exception])

def var_pin(val)
  a = 0
  case val
    in ^a
      [:zero, a]
  else
    :nothing
  end
end

p "-" * 10
p var_pin(0)
p var_pin(1)

def alt(val)
  case val
    in 0 | -1..1 | Integer
    :zero_or_range_or_class
  else
    :nothing
  end
end

p "-" * 10
p alt(0)      # => zero_or_range_or_class
p alt(1)      # => zero_or_range_or_class
p alt(-1)     # => zero_or_range_or_class
p alt(100000) # => zero_or_range_or_class
p alt("1")    # => nothing

def pat(val)
  case val
    in 0 => a
    [:zero, a]
    in -1..1 => a
    [:range, a]
    in Integer => a
    [:class, a]
  else
    :nothing
  end
end

p "-" * 10
p pat(0)      # => [:zero, 0]
p pat(1)      # => [:range, 1]
p pat(-1)     # => [:range, -1]
p pat(100000) # => [:class, 100000]
p pat("1")    # => nothing
