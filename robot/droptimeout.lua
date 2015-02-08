robot = require("robot")
sleep = os.sleep

function drop()
  for i = 1,16 do
    if robot.count(i) > 0 then
      robot.select(i);
      if robot.drop(1) then return true
      end
    end
  end
  return false, "Could not drop. Empty?";
end

function pickup()
  robot.suck()
end

function cycle()
  drop()
  sleep(4)
  pickup()
  sleep(11)
end

while true do cycle() end 
