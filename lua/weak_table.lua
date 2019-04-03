local mt = {}
--inspired by skynet redis.lua
mt.__index = function(t, k) 
	local f = function(self, ...)
		print(self)
		return ... 
	end
	--t[k] = f
	return f
end

local t = {}
setmetatable(t, mt)
print(t:a('b', 'bb', 'cc'))
print(string.format('t:%s', t))

a = {}
b = {}
setmetatable(a, b)
b.__mode = "kv" -- now 'a' has weak keys
key = {} -- creates first key
table.insert(key, 1)
a[key] = 1
a['a'] = key
key = {} -- creates second key
a[key] = 2
collectgarbage() -- forces a garbage collection cycle
for k, v in pairs(a) do print(k,v) end
