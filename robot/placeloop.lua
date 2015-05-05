robot = require "robot"

function place()
  for i = 1,8 do
    if robot.count(i) > 0 then
      robot.select(i);
      if robot.place() then return true
      end
    end
  end
  return false, "Unknown error in place()";
end

while true do
  while robot.detect() do os.sleep(1) end
  place()
end

