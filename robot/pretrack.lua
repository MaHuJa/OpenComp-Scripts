robot = require ("robot")

function place()
  if robot.detectDown() then return true end
  for i = 1,16 do
    if robot.count(i) > 0 then
      robot.select(i);
      if robot.placeDown() then return true end
    end
  end
  return false, "Unknown error in place()";
end

function up()
  robot.swingUp();
end
function fwd()
  robot.swing();
end
function down()
  robot.swingDown();
  if not robot.detectDown() then assert(place(),"Unable to fill below"); end
end
  
function cycle()
  up() fwd() down()
  robot.forward()
end

while true do cycle() end
