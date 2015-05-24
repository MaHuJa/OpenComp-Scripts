-- Toggle RS rapidly
local side = 5 -- left
wait = computer.pullSignal;
rs = component.proxy(component.list("redstone")())
while true do
  rs.setOutput(side,255);
  wait(0.03);
  rs.setOutput(side,0);
  wait(0.03);
end

