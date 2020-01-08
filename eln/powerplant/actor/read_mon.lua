comp = comp or require ("component");
eln = eln or comp.ElnProbe;

monitor = monitor or dofile ("monitor.lua");

local t = {};

for _,v in ipairs(monitor) do
    t[v.signalname] = eln.wirelessGet(v.signalname);
end

return t;
