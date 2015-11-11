--[[
Background task for
Big reactors actively cooled reactor.
(aka steam reactor)

Unlike turbines, I'm making the assumption that there is only one reactor on a computer net.

Important observation:
Reactor temperature will continue to build when it doesn't have coolant flow.
This means we can scale our reactor output based on current heat levels.
getFuelTemperature getCasingTemperature

Other inputs of note:
- If the hot buffer is full, getHotFluidProducedLastTick equals demand.
- A big difference between getHotFluidAmount getHotFluidAmountMax is an indicator that we need to turn up quickly.



Figure out the "desired temperature" to scale against. 
1950 should be at the top end. Perhaps make it scale with getHotFluidProducedLastTick ?

]]
 
component = require ("component");
event = require ("event");
local reactor = component.br_reactor; 

assert (reactor.isActivelyCooled(), "This program is for actively cooled (steam producing) reactors.");

local function tick()
	local hot = reactor.getHotFluidAmount()
	if hot < 20000 then -- deficit
		reactor.setAllControlRodLevels(0)
	end
	local temp = reactor.getFuelTemperature();
	local factor = temp/500;	-- higher temp
	reactor.setAllControlRodLevels(math.min(factor*100,100)); -- means lower effect
end

_G.reactorad_pid = _G.reactorad_pid or {};
local pid = event.timer(0.8,tick,math.huge);
table.insert(_G.reactorad_pid,pid)
