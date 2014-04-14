robot  = require "robot"
params = {...}
local _
-- Convert Params

function multicaller(func,count)
  return function()
    for _ = 1,count do
      func()
    end
  end
end

instruction = {
  right = robot.turnRight,
  left = robot.turnLeft,
  forward = robot.forward,
  fw = robot.forward,
  back = robot.back,
  backward = robot.back,
  up = robot.up,
  down = robot.down,

}

ilist = {} -- instruction list to be done later

local i,func,count
i = 1
while i <= #params do
  func = instruction[string.lower(params[i])]
  if not func then
    error ("Invalid parameter " .. i .. ": " .. params[i])
  end
  count = tonumber(params[i+1])
  if count then
    i = i+ 1
    ilist[#ilist+1] = multicaller(func,count)
  else
    ilist[#ilist+1] = func
  end
  i = i + 1
end

-- Now get to work
local v
for _,v in ipairs(ilist) do v() end