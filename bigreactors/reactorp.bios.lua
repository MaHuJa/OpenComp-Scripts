function com(s)
  local c = component
  local r = c.list(s)()
  return c.proxy(r)
end
local reactor = com "br_reactor";

if not reactor.getActive() then
  --reminder
  computer.beep(200,0.5)
	computer.beep(180,0.2)
end

while true do
	local factor = reactor.getEnergyStored()/reactor.getEnergyCapacity();
	factor = math.max(factor,0);
	factor = math.min(factor,1)
	reactor.setAllControlRodLevels((1-factor)*100);
	computer.pullSignal(2);
end

