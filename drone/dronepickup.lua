c = component
d = c.list "drone"
d = c.proxy(d())
comp = c.list "computer"
comp = c.proxy(comp())
nav = c.proxy(c.list("navigation")())
modem = c.proxy(c.list("modem")())

modem.open(7)
p = modem.broadcast

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

function goDeliver()
  d.move(table.unpack(waypoint("Importchest")))
  wait()
  for i=1,8 do
    d.select(i)
    d.drop(0)
  end
end

function goPickup(at)
  d.move(table.unpack(waypoint(at)))
  wait()
  d.select(1)
  for i=1,8 do 
    d.select(i)
    d.suck(0)
  end
end

while true do
  goPickup("Farmchest")
  goPickup("enderfarm")
  goPickup("btfarm")
  goDeliver()
  for i = 1,10 do  -- reputedly forces GC
    computer.pullSignal(3)
  end
end


