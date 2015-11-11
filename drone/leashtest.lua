function com(s)
  local c = component
  local r = c.list(s)()
  return c.proxy(r)
end
leash = com "leash"
for i = 0,5 do
  leash.leash(i)
end
drone = com "drone"
drone.move(0,100,0)
repeat
  computer.pullSignal(1)
until drone.getVelocity() < 0.1;
leash.unleash()


