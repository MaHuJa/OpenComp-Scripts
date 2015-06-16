robot = require "robot"

params = {...};
if params[1] == '-h' then
  print (
[[Usage: placeline_n stepsize countsteps function
  stepsize - place this many blocks     9
  countsteps - how many groups to run   4
  function - what to do after each step "robot.right()"
]]);
  return false;
end

assert (not params[1] or tonumber(params[1]), "Stepsize param is not a number");
local stepsize = assert(tonumber(params[1]));

assert (not params[2] or tonumber(params[2]), "Count param is not a number");
local length = assert(tonumber(params[2]));

local func = assert(load(params[3]));

function place()
  if robot.placeDown() or robot.detectDown() then return true end
  if robot.count(robot.select()) == 0 then
    for i = 1,16 do
      if robot.count(i) > 0 then
        robot.select(i);
        return robot.placeDown();
      end
    end
  end
  return false, "Cannot place(). Out of blocks?";
end

local function forward()
	assert(place())
	assert(robot.forward())
end


for _ = 1,length do
  forward()
  forward()
  forward()
  func();
  io.write '.'
end

