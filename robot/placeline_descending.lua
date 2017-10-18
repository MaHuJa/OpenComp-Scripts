robot = require "robot"

params = {...};
local stepsize = tonumber(params[1]) or 3;
length = tonumber(params[2]) or math.huge;

function place(fn)
  if fn() then return true end
  if robot.detectDown() then return true end
  if robot.count(robot.select()) == 0 then
    for i = 1,16 do
      if robot.count(i) > 0 then
        robot.select(i);
        return fn();
      end
    end
  end
  return false, "Cannot place(). Out of blocks?";
end

local function forward()
	assert(place(robot.placeDown))
	assert(robot.forward())
end


for _ = 1,length do
  for step = 1,stepsize do
    forward()
  end
  assert(robot.down())
  io.write '.'
end

