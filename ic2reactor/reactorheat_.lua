component = require "component"
sides = require "sides"
event = require "event"

rs = component.redstone
rs_side = sides.north
reactor = component.reactor_redstone_port
heatlimit = 4000

function on()
  rs.setOutput(rs_side,15)
end
function off()
  rs.setOutput(rs_side,0)
end
function run()
	local heat = reactor.getHeat()
	if heat < heatlimit then on() else off() end
	if event.pull(10) ~= "interrupted" then return run() end
end

print (pcall(run))
off()

