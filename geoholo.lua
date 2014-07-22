function eval(value)
  return value < 0.1
end
rounds = 1
component = require "component";
geo = component.geolyzer;
holo = component.hologram;

offset = 24;

function multirun(x,z,times)
  local t = geo.scan(x,z)
  if times < 2 then return t end;
  local count = times-1;
  while count>0 do
    local add = geo.scan(x,z)
    for k,v in ipairs(add) do
      t[k] = t[k]+v;
    end
  end
  for k,v in ipairs(t) do
    t[k]=v/times;
  end
  return t;
end

for x = -offset,offset,1 do
  for z = -offset,offset,1 do
    local t = multirun(x,z,rounds);
    local t = geo.scan(x,z); -- todo: average multiple for higher rounds
    for k,v in ipairs(t) do
      holo.set(x+offset,k,z+offset,eval(v));
    end
  end
end


