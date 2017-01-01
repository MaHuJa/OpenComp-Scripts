local src = 5 --left
local dst = 4 --right

sleep = computer.pullSignal;
function com(s) return component.proxy(component.list(s)()) end

local trans = com"transposer"

while true do
  while (trans.getTankLevel(dst)>0) do sleep(0.5) end
	trans.transferFluid(src,dst,trans.getTankCapacity(dst))
end
