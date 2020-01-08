read_mon = read_mon or loadfile("read_mon.lua");
read_sw = read_sw or loadfile("read_sw.lua");

local t = {
    timestamp = os.date("%F %T"),
    monitor = read_mon();
    switch = read_sw();
};

return t;
