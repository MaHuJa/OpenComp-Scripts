-- Toggle RS rapidly
local side = 5 -- left

rs = component.proxy(component.list("redstone")())
while true do
  rs.setOutput(side,255);
  rs.setOutput(side,0);
end

