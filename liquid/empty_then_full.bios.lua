local src = 5 --left
local dst = 4 --right

sleep = computer.pullSignal;
function com(s) return component.proxy(component.list(s)()) end

local trans = com"transposer"

local modem = com"modem"
if modem then
	local t = {};
	for i = 0,5 do 
		table.insert(t,trans.getTankCapacity(i)) ;
	end
	modem.broadcast(1,table.unpack(t));
end

while true do
  while (trans.getTankLevel(dst)>0) do sleep(0.5) end
	trans.transferFluid(src,dst,trans.getTankCapacity(dst))
end
