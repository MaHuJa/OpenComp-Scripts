local dumpside = 1; --top

function com(s)
  local c = component
  local r = c.list(s)()
  return c.proxy(r)
end

local robot = com"robot";

function dumpslot(slot)
  if robot.count(slot)>0 then
	  robot.select(slot);
		robot.drop(dumpside);
	end
end

function dumpall()
  for i=1,robot.inventorySize() do
	  dumpslot(i);
	end
	robot.select(1);
end

while true do
	while not robot.swing(3) do computer.pullSignal(10) end
	for i=1,64 do robot.swing(3) end
	dumpall();
end
