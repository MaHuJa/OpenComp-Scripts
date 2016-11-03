local sides = require "sides"
local component = require "component"
local event = require "event"

local rs = component.redstone
local tank = component.deepresonance_tank

local function debugout (str)
  io.write(str)
end

function loop()
  while event.pull(1) ~= "interrupted" do
	  if tank.getStrength() < 0.699 and tank.getPurity() > 0.15 then
		  rs.setOutput(sides.down,2)
			debugout "+"
	  else 
		  rs.setOutput(sides.down,0)
			debugout "-"
		end
	end
end

print(pcall(loop))
rs.setOutput(sides.down,0)
