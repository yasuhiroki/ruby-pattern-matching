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

p value(0)      # => zero
p value(1)      # => range
p value(-1)     # => range
p value(100000) # => class
p value("1")    # => nothing

