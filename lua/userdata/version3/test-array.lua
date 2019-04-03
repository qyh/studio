local array = require "array"

a = array.new(100)
print(a)

print(a:size())
for i=1, 10 do
	a:set(i, 1/i)
end

print(a:get(10))
