robot = require("robot")
component = require ("component")
rs = component.redstone
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

function maxrs()
  local ret = 0
  for i = 0,5 do
    ret = math.max(res,rs.getInput(i))
  end
end

function cycle()
  drop()
  sleep(4)
  pickup()
  sleep(11)
  while maxrs() > 0 do sleep(1);
end

while true do cycle() end 
