local array = require "array"

a = array.new(100)
print(a)

print(a:size())
for i=1, 10 do
	a[i] = 1/i
end

print(a[10])
a[10] = 10
print(a:get(10))
print(a)
