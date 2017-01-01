local src = 5 --left
local dst = 4 --right

sleep = computer.pullSignal;
function com(s) return component.proxy(component.list(s)()) end

local trans = com"transposer"

while true do
  local dstmax = trans.getTankCapacity(dst)
	local dstnow = trans.getTankLevel(dst)
	local amt = (dstmax/2)-dstnow;
	if (amt>0) then
		trans.transferFluid(src,dst,amt)
	end
	sleep(1)
end

