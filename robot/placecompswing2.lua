robot = require ("robot")

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

function harvest()
  robot.select(16)
  if robot.compare() then 
    robot.select(9)
    robot.swing() 
  end
end

function cycle()
  harvest()
  if not robot.detect() then place() end
  robot.turnRight()
  os.sleep(2)
  robot.turnRight()
end

while true do cycle() end 
