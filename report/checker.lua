-- dependencies
local component = require "component";
local computer = require "computer";
local eln = component.ElnProbe;
local inet = component.internet;

-- Load settings
do
	local settings, err = loadfile "settings.lua";
	if settings then settings() else print("Warning: Could not open settings: ",err) end
end

-- Utility functions
function round2(num) return math.floor(num*100)/100; end

-- Error rate limiter
local timeout = timeout or {
	exvolt = 0;
	involt = 0;
	sink = 0;
};
function check_timeout (name)
  local now = computer.uptime();
	local timetarget = timeout[name] or 0;
	local retval = timetarget < now;
	timeout[name] = now + 60;  -- Effectively; do not report again unless it has been ok for 60 seconds
	return retval;
end

-- Perform the check
local function checkPower()
  -- Scaled to their actual values. SENSOR SETUP!
	exvoltp = exvolt;
	exvolt = eln.wirelessGet("exvolt")*4000;		-- 0-4000 V
	involtp = involt;
	involt = eln.wirelessGet("involt")*4000;		-- 0-4000 V;
	sinkp = sink or -1;
	sink = (eln.wirelessGet("Powersink") or -1) * 100;
	
	output1p = output1 or 0;
	output1 = eln.wirelessGet("Output1_16kW") or 0;	-- calcs performed in report prep
	output2p = output2 or 0;
	output2 = eln.wirelessGet("Output2_16kW") or 0;

	local report = false;
	local timenow = computer.uptime();
	
	if (exvolt<3150) and check_timeout("exvolt")
		or (involt<3150) and check_timeout("involt") 
		or (sink == 0 and sinkp == 0 and check_timeout("sink")) 
		or not exvoltp -- first run
		then
		report = true;
	end
	
	if (report) then
		msg = { 
			"Power alert:\n",
			"External ", 
			round2(exvolt), 
			"V (from " , 
			round2(exvoltp or 0),
			"V)\n",
			"Internal ",
			round2(involt), 
			"V (from " , 
			round2(involtp or 0),
			"V)\n",
			"Sink ",
			round2(sink), 
			"% (from " , 
			round2(sinkp or 0),
			"%)\n",
			"Output ",
			round2((output1+output2)*16000),		-- calculation logic here!!!
			"W (from ",
			round2((output1p+output2p)*16000),
			"W) balance ",
			output1/output2,
		};
		do_report (msg)
	end
end

local charcontainer = component.mcp_mobius_betterbarrel;
assert (charcontainer.getStoredItemType()['label']=='Charcoal', "Not a charcoal barrel!");
local function checkCharcoal()
	local charcoal = charcontainer.getStoredCount();
	local charcoal_max = charcontainer.getMaxStoredCount();
	
	local percent = charcoal/charcoal_max;
	local report = false;
	if percent < 0.5 and check_timeout("charcoal50") 
	  or percent < 0.2 and check_timeout("charcoal20")
		or percent == 0 and check_timeout("charcoal0")
		then 
		report = true; 
	end;
	
	if report then
		msg = "Charcoal at " .. charcoal .. "/" .. charcoal_max;
		do_report(msg);
	end
end

function do_report (msg)
	assert (slackpost, "Slackpost not set.");
	if (type(msg)=='table') then
		_, msg = pcall (table.concat,msg);
	end
	local json = 
		[[{ "username":"BaseMonitor", "text": "]]	.. msg .. [["}]];
	local req,err = inet.request(slackpost,json);
	if not req then print(err) end;
	
	local file = io.open("logfile","a");
	file:write(msg,'\n');
	if not req and err then file:write(err'\n') end
	file:write('\n');
	file:close();
end

do_report("Starting base monitor v2");

while true do 
	os.sleep(5)
	checkPower();
	checkCharcoal();
end


