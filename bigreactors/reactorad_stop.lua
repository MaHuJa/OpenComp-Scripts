component = require ("component");
event = require ("event");

local reactor = component.br_reactor; 
reactor.setActive(false);
reactor.setAllControlRodLevels(100);

_G.reactorad_pid = _G.reactorad_pid or {}
for _,pid in ipairs(_G.reactorad_pid) do
	event.cancel(pid)
end
