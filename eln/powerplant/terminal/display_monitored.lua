comp = comp or require ("component");
colors = colors or require ("colors");
gpu = gpu or comp.gpu;

monitor = monitor or dofile("monitor.lua");
values = ... ;

local entrywidth, entryheight = 30, 3;
local adjust_to = 16;
local firstline = 3;
gpu.setBackground(0);
gpu.fill(1,firstline,entrywidth,entryheight*(#monitor+1),' ');

for count,mon in ipairs(monitor) do
    local line = count * entryheight + firstline;
    gpu.set(1,line,mon.display);
    local data = mon.transform(values[mon.signalname])
    gpu.set(adjust_to-#data,line+1,data);
    gpu.set(adjust_to+1, line+1, mon.unitname)
    -- Todo: display old value, and/or color by up/down
end
