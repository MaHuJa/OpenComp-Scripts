battery = battery or component.mfsu
local reactor = (...)
local stored = battery.getStored()
battery_max = battery_max or battery.getCapacity()

reactor_output = reactor_output or 2048

local output = reactor.getReactorEnergyOutput()
if output ~= 0 then 
  reactor_output = output
end

local sent = reactor_output * 200

if stored+sent > battery_max then return false end
return true
