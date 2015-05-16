-- Creeper Sentinel
-- Uses computronics radar
-- ...which costs way too much power to be practical in a portable format

maxdistance = 30;
rate = 1;
function isTarget(e)
  return e.name=="Creeper"
end

component = require ("component");
radar = component.radar;
computer = require ("computer");

local closest = math.huge;
function checkdist(e)
  closest = math.min(closest,e.distance);
end



while true do
  closest = math.huge;
  all = radar.getMobs(maxdistance);
  for _,v in ipairs(all) do
    if isTarget(v) then checkdist(v) end
  end
  if closest < maxdistance then
    local freq = 2000 - closest*100
    computer.beep(freq,0.25);
  end
  os.sleep (rate)
end

