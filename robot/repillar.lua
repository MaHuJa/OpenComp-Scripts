local component = require "component";
local robot = assert(component.robot);
local params = {...};
local maxcount = assert(tonumber(params[1]));
local sides = require "sides";

for i = 1,maxcount do
  robot.swing(sides.down);
  assert(robot.move(sides.down));
end
os.sleep(1);
for i = 1,maxcount do
  assert(robot.move(sides.up));
  robot.place(sides.down);
end

