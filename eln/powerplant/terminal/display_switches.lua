comp = comp or require ("component");
colors = colors or require ("colors");
gpu = gpu or comp.gpu;


local switch_status = ...;
switch_set = switch_set or {};

if not switches then
    switches = dofile ("switches.lua");
    for _,v in ipairs(switches) do
        switch_set[v.signal] = 0;
    end
end

-- in the future, will read from a received table.

local scrwidth,scrheight = gpu.getResolution();
local switch_width = 16;
local switch_height = 3;

for vertical,category in ipairs(switches) do
    for horizontal,switch in ipairs(category) do
        if switch_set[switch.signal] > 0.5 then
            gpu.setBackground(0x007f00)
        elseif switch_status[switch.signal] > 0.5 then
            gpu.setBackground(0x00007f)
        else
            gpu.setBackground(0x7f0000)
        end
        local x = scrwidth - horizontal * switch_width;
        local y = (vertical - 1) * switch_height + 1;
        gpu.fill(x, y, switch_width, switch_height, ' ');     
        -- todo center align
        gpu.set(x+1, y, category.category);
        gpu.set(x+1, y+1, switch.name);
    end
end
gpu.setBackground(0);


