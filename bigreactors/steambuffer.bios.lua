function com(s)
  local c = component
  local r = c.list(s)()
  return c.proxy(r)
end
local buffer = com "tank_controller";
local bufferside = 0;
local reactor = com "br_reactor";
local redstone = com "redstone";
local redstoneside = 5; --sides.left

redstone.setOutput(redstoneside,15);  -- turn on reactor; turn off on controller failure

while true do
	local factor = buffer.getTankLevel(bufferside)*2 / buffer.getTankCapacity(bufferside);
	factor = math.max(factor,0);
	factor = math.min(factor,1)
	reactor.setAllControlRodLevels(factor*100);
	computer.pullSignal(2);
end

