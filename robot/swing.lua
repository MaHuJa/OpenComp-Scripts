local args = {...}
local count = args[1] or 1
count = tonumber(count)

robot = require ("robot")

for i = 1,count do
	robot.swing()
end
