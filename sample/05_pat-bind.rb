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

p pat(0)      # => [:zero, 0]
p pat(1)      # => [:range, 1]
p pat(-1)     # => [:range, -1]
p pat(100000) # => [:class, 100000]
p pat("1")    # => nothing

