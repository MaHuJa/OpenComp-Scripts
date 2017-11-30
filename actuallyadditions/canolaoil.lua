-- robot = require ("robot");
local component = require ("component");
local robot = component.robot;
local sides = require "sides";

local sourcetank = sides.front;
local workvox = sides.down;
local dumpto = sides.up; --sides.up

--assert (robot.tankCount()>=2);

local function loadfluid()
  --may check (tank empty or compare fluid)
  robot.selectTank(1);
	local _,x = robot.drain(sourcetank, robot.tankSpace());
  print("Loading ", x);
  if (robot.tankLevel()<1000) then
		os.sleep(1);
		return loadfluid();
	end;
end;

-- Will need changing for the 2-item drop if I decide to make that
local function dropDown()
	if robot.count(robot.select()) == 0 then
		for i = 1,16 do
			if robot.count(i) > 0 then
				robot.select(i);
				return robot.drop(workvox,1);
			end
		end
		return false;
	end
	return robot.drop(workvox,1);
end

local function work()
	io.write('.');
	robot.selectTank(1);
	assert(robot.fill(workvox,1000));
	assert(dropDown());
	robot.selectTank(2);
	assert(robot.drain(workvox,1000));
end

local function dumpfluid()
	robot.selectTank(2);
	repeat
		local _,x = robot.fill(dumpto,robot.tankLevel());
		print ("Dumping ", x);
		os.sleep(1);
	until robot.tankLevel()==0;
end

while true do 
	dumpfluid();
	loadfluid();
	while robot.tankLevel(1)>=1000 do 
		work();
	end;
	io.write('\n');
	os.sleep(1);
end;
