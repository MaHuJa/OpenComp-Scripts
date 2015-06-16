robot = require "robot";
event = require "event";

function tryplace()
  return robot.placeDown() or robot.detectDown()
end

function place(fn)
  if fn() then return true end
  for i = 1,robot.inventorySize() do
    if robot.count(i) > 0 then
      robot.select(i);
      if fn() then return true
--      else robot.drop(64)
      end
    end
  end
  return false, "Cannot place(): Probably empty";
end

function line()
  repeat
    place(tryplace);
  until not robot.forward();
  assert(robot.up() and robot.turnRight() and robot.turnRight());
end

while event.pull(0) ~= "interrupted" do line() end
