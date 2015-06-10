--[[
Background task for
Big reactors actively cooled reactor.
(aka steam reactor)

Unlike turbines, I'm making the assumption that there is only one reactor on a computer net.

We want the reactor to auto-tune to demand. I dont' see a way to do this well with a stateless program.
isActivelyCooled 
- If the hot buffer is full, getHotFluidProducedLastTick equals demand.
getHotFluidAmount == ?
- If the hot buffer is not full, getHotFluidProducedLastTick equals production. 

- Does getEnergyProducedLastTick == getHotFluidProducedLastTick ?
If not, this could be all I need.

A full steam buffer means throttle back, an empty steam buffer means go higher.
This feedback will tend to be abrupt, while our actions have delayed effects.

- Do linear fallback on production until we detect it too low, then bump it up a bit?
- Scale CR setting to clamp down the bracket around the value? (Accounting for demand changing!)

]]
 
component = require ("component");
event = require ("event");
reactor = component.br_reactor; 




 