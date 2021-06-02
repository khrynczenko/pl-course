3.times { puts "hi" }
puts "-------------------"
[1, 2, 3].each { |x| puts x }
puts "-------------------"
x = [1, 2, 3]
y = x.map { |x| x + x }
y.each { |x| puts x }
puts "-------------------"
x = [1, 2, 3]
puts(x.any? { |x| x > 7 })
puts(x.any? { |x| x > 2 })
puts(x.all? { |x| x > 2 })
puts "-------------------"
x = [1, 2, 3]
puts(x.inject { |acc, x| acc + x})
