robot = require "robot"

length = tonumber(...)
if not length then error "Length needed" end

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
  return false, "Unknown error in place()";
end

for _ = 1,length do
  assert(place(robot.placeDown))
  assert(robot.forward())
  io.write '.'
end
