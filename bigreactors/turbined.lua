--[[
	Daemon for controlling turbine.
	This script can be run once for each connected turbine, to allow controlling all of them from a single computer.
	
]]

--[[
- Analog (match power demand) or digital (turn on, wait until storage is charged, turn off) control?
Turbines have no easy way of doing analog control; digital on/off in proportion is the only way to do this.

- Coordinated spin-ups if spinning up all of them would go over available steam supply?

- Will use max flow rate. There's no way to sense if it has enough blades to do this effectively.

]]

component = require ("component");
event = require ("event");

local function steamsupply(T)
	local rpm = T.getRotorSpeed()
	local maxsteam = T.getFluidFlowRateMaxMax()
	if rpm < 1850 then 
		T.setFluidFlowRateMax (maxsteam)	-- TODO
	elseif rpm > 1950 then
		T.setFluidFlowRateMax (0)
	else
		local factor = (rpm-1850)/100;
		T.setFluidFlowRateMax (factor*maxsteam);
	end
end

local function coilcheck(T)
	local rpm = T.getRotorSpeed();
	if rpm < 1800 then 
		T.setInductorEngaged(false);
	elseif rpm > 1980 then
		T.setInductorEngaged(true);
	else 
		T.setInductorEngaged( T.getEnergyStored() < 0.6*T.getEnergyStoredMax() );
	end
end

local function setup(addr)
	local turb = component.proxy(addr);
	local function tick();
		steamsupply(turb);
		coilcheck(turb);
	end
	local pid = event.timer(0.8, tick, math.huge);
	turb.setActive(true);
	_G.turbined_pids = _G.turbined_pids or {};
	table.insert(_G.turbined_pids,pid);
end

for addr in component.list("br_turbine") do
	setup(addr)
	print ("Turbine ",addr)
end

