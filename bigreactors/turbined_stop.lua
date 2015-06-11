component = require "component"
event = require "event"

for addr in component.list("br_turbine") do
	component.invoke(addr,'setActive',false)
end

pids = _G.turbined_pids;
if pids then
	for _,v in ipairs(pids) do
		event.cancel(v)
	end
end
_G.turbined_pids = {}
