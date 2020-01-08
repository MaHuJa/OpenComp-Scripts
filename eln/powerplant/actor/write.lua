comp = comp or require ("component");
eln = eln or comp.ElnProbe;

flags = ...

for k,v in pairs(flags) do
    eln.wirelessSet(k,v);
end

