c = component
d = c.list "drone"
d = c.proxy(d())
comp = c.list "computer"
comp = c.proxy(comp())
nav = c.proxy(c.list("navigation")())
modem = c.proxy(c.list("modem")())

--modem.open(7)
p = function() end -- modem.broadcast

function wait()
  repeat computer.pullSignal(1) until d.getOffset() < 0.3;
end

function waypoint(name)
  p(8,"Going to " .. name)
  for _,v in ipairs(nav.findWaypoints(120)) do
    if v.label == name then
      return v.position
    end
  end
  local s = "Could not find waypoint"
  p(8,s) 
  error(s)
end

function wpmod (wp,mod)
  wp[1],wp[2],wp[3] = wp[1]+mod[1], wp[2]+mod[2], wp[3]+mod[3]
  return wp
end

while true do
  d.move(wpmod(waypoint("Farmchest"),{0,0,-0.5}))
  wait()
  repeat d.drain(0) until d.tankSpace() == 0;
  d.move(wpmod(waypoint("sludgefarm"),{0.5,0,0}))
  wait()
  repeat d.fill(0) until d.tankLevel() == 0;
  
--[[
  for i = 1,10 do  -- reputedly forces GC
    computer.pullSignal(3)
  end
--]]
end


