def alt(val)
  case val
    in 0 | -1..1 | Integer
    :zero_or_range_or_class
  else
    :nothing
  end
end

p alt(0)      # => zero_or_range_or_class
p alt(1)      # => zero_or_range_or_class
p alt(-1)     # => zero_or_range_or_class
p alt(100000) # => zero_or_range_or_class
p alt("1")    # => nothing

