robot = require "robot"
component = require "component"
robotc = component.robot;

params = {...};
forwardlength = params[1] or 64;
rightwidth = params[2] or 4;

local vanilla_robot_forward = robot.forward;
function robot.forward()
  local res, err
  repeat 
    res,err = vanilla_robot_forward()
  until res or err ~= "already moving";
  return res,err
end

function digline(length)
  for i=1,length do 
    -- deal with sand/gravel
    repeat q=robot.swing() os.sleep(0.3) until not robot.detect();
    w=robot.swingUp() 
    e=robot.swingDown() 
    assert(robot.forward()) -- assert so we don't start digging outside designated area
  end
end

function shiftback(right)
  robotc.turn(right)
  robot.swing()
  robot.forward()
  robotc.turn(right)
end

function cycle(count)
  digline(forwardlength);
  shiftback(count%2==1)
end

for i=1,rightwidth do cycle(i) end
