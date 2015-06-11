--[[
Background task for
Big reactors actively cooled reactor.
(aka steam reactor)

Unlike turbines, I'm making the assumption that there is only one reactor on a computer net.

Important observation:
Reactor temperature will continue to build when it doesn't have coolant flow.
This means we can scale our reactor output based on current heat levels.

Other inputs of note:
- If the hot buffer is full, getHotFluidProducedLastTick equals demand.

Figure out the "desired temperature" to scale against. 
1950 sounds fine.

]]
 
component = require ("component");
event = require ("event");
local reactor = component.br_reactor; 

assert (reactor.isActivelyCooled(), "This program is for actively cooled (steam producing) reactors.");




 