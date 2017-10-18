function com(s)
  local c = component
  local r = c.list(s)()
  return c.proxy(r)
end
 
local robot = com"robot"
 
while true do robot.swing(3) end -- forward