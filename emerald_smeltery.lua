component = require "component";
sides = require "sides";

local smelter_side = sides.east;
local basin_side = sides.down;
local storage_side = sides.up;

local basin_capacity = 5760;



tp = component.transposer;

while true do
	if tp.getTankLevel(smelter_side) <= basin_capacity then
		os.sleep(20);
	else
		local _,amt = tp.transferFluid(smelter_side,basin_side,basin_capacity);
		print (amt);
		assert(amt==basin_capacity, "Fluid transfer error");
		repeat 
		  os.sleep(1)
		until tp.transferItem(basin_side,storage_side);
	end
end

