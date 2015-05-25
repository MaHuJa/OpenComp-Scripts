--[[
  Slaughterhouse
  Robot part
]]

component = require "component";
robot = component.robot;
modem = component.modem;

modem.open(0xBEEF);
modem.setStrength(20);

function checksword()
end

function wait()
  event.pull ('modem_message',_,_,_,_,'butcher','kill');
end

function check_inventory()
  
end

function kill()
  repeat robot.swing()
  until check_inventory()
end

function dump()
end

while true do
  checksword()
  wait()
  kill()
  dump()
end
