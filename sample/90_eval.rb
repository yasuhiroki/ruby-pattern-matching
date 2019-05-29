case { a: 1, b: 2 }
  in {a: 1}
end

p eval("{a: 1}") # => {a: 1}

# case { a: 1, b: 2 }
  # in eval("{a: 1}") # => syntax error
# end
