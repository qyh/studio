local sqlite = require "sqlite"
print('test.lua')
local o = sqlite.new("./testDB.db");
print(o:test(a, function(t)
	print('on callback function')
	print(string.format('a:%s', a))
	for k, v in pairs(t) do
		print(k, v)
	end
end))

local r = o:exec("select * from user;", function(rv) 
	print('on call back :')
	if rv then
		for k, v in pairs(rv) do
			print(k, v)
		end
	end
end)
print('exec return :', r)
