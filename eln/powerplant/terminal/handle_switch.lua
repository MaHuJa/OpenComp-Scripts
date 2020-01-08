
-- keep in sync with display_switches.lua
local switch_width = 16;
local switch_height = 3;

function debugout(s)
    gpu.set(60,40,s);
end
debugout = print;

local function clickhandler(_,screenaddr,x,y,button, name)
    print ("clickhandler",switches,screenaddr,x,y,button,name);
    assert (switches);
    local row = math.floor((y-1)/3+1);
    print (row);
    row = switches[row];
    if not row then return end;
    local column = (gpu.getResolution()-x)/switch_width;
    column = math.floor(column+1)    
    column = row[math.floor(column)];
    if not column then return end;

    local signal = column.signal;
    if switch_set[signal] > 0.5 then
        switch_set[signal] = 0;
    else switch_set[signal] = 1;
    end

    sendswitches(switch_set);   -- could instead send only the changed one?
end

event.listen('touch',clickhandler);
