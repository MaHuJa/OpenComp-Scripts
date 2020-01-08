clock = clock or loadfile("clock.lua");
display_monitored = display_monitored or loadfile ("display_monitored.lua");
display_switches = display_switches or loadfile ("display_switches.lua");

t = ...;

clock();
gpu.set(1,2,t.timestamp);
display_monitored(t.monitor);
display_switches(t.switch);

