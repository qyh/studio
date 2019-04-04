local sqlite = require "sqlite"
print('test.lua')
local o = sqlite.new("./testDB.db");
print(o:test())
