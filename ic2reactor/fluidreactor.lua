
reactorside = require ("sides").east;
local component = require ("component");
local event = require ("event");

-- Check fluids
-- returns  hot&cold, hot, cold
local tc = component.tank_controller;
function check_fluids()
  local tanks = tc.getFluidInTank(reactorside);
	local cooltank = tanks[1];
	local hottank = tanks[2];
	
	local cold = cooltank.amount > 5000;
	local hot = hottank.amount < 5000;
	
	return cold and hot, hot, cold;	
end

-- Check items
-- has fuel, not missing components
-- returns f&c, fuel, components
local ic = component.inventory_controller;

function check_items()
	return true, true, true
end

--[[
function check_items()
  local fuel, components = false,false;
	for i = 1,ic.getInventorySize() do
	  local stack = ic.getStackInSlot(i)
		
	end
	return fuel and components, fuel, components
end
]]

-- Loop
local rs = component.redstone;

function cycle()
	-- simplified version, no real reporting
	if (check_fluids()) and (check_items()) then
	  rs.setOutput(reactorside, 1);
		io.write("+");
	else
	  rs.setOutput(reactorside, 0);
		io.write("-");
  end
end

function loop()
  while event.pull(10) ~= 'interrupted' do 
	  cycle()
	end
end

print(pcall(loop))
rs.setOutput(reactorside, 0);




