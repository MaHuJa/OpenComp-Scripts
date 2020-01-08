print "Starting local, non-networked power plant control";

monitor = dofile "/home/monitor.lua";
switches = dofile "/home/switches.lua";

switch_set = {};
for _,v in ipairs(switches) do
    for _,w in ipairs(v) do
        switch_set[w.signal] = 0;
    end
end


function req(n, ...)
    _ENV[n] = require (n);
    if ... then return req(...) end
end
function fnc(n, ...)
    _ENV[n] = loadfile (n .. '.lua');
    if ... then return fnc(...) end
end
req('event','component')
com = component;
fnc('read_mon','read_sw','read','write','clock',
    'display_all', 'display_monitored','display_switches')

dofile ('handle_switch.lua');
clocktimer = event.timer(0.6,clock,math.huge);

-- replace 'network' functionality
function sendswitches(t)
    write(t)
end

local max_x, max_y = component.gpu.getResolution();
component.gpu.fill(1,1,max_x,max_y,' ');

while true do
    t = read();
    display_all(t);
    os.sleep(1);
end



