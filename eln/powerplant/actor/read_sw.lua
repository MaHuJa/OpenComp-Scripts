comp = comp or require ("component");
eln = eln or comp.ElnProbe;

switches = switches or dofile ("switches.lua");

local t = {};

for _,v in ipairs(switches) do
    for _,w in ipairs(v) do
        t[w.signal] = eln.wirelessGet(w.signal);
    end
end

return t;
