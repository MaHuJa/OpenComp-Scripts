--[[
  Nanomachines lib

]]

local port = 42;

local component = require "component";
local modem = component.modem;
modem.open(port);
local event = require "event";

local nanoaddr;
local nano = {};  -- table to be returned

local function query(...)
  local strength = modem.getStrength();
  modem.setStrength(2);
  modem.broadcast(port, "nanomachines", ...);
  modem.setStrength(strength);
  
  local t = { event.pull(3, "modem_message", modem.addr, nanoaddr, port )};
  if not t then return nil,"timeout" end
--[[
  if not nanoaddr then
    local dist = assert(t[5],"No message distance");
    if dist<=2 then 
      nanoaddr = assert(t[3],"No message source");
    end
  end
--]]
  table.remove(t,1);  --evt
  table.remove(t,1);  --laddr
  table.remove(t,1);  --raddr
  table.remove(t,1);  --port
  table.remove(t,1);  --dist
  table.remove(t,1);  --"nanomachines"
  return table.unpack(t); --msg...
end
query("setResponsePort",port);
_G.q = query;

-- mundane part

function nano.setResponsePort(num)  -- not sure if this should really be in there.
  -- todo: parameter checking
  query("setResponsePort",num);  -- TODO: What happens if it's out of power?
  modem.close(port);
  port = num;
  modem.open(port);
end

function nano.getPowerState() 
  local str, cur, max = query("getPowerState"); 
  assert (str=="power");
  return cur,max;
end
function nano.getHealth() 
  local str, cur, max = query("getHealth"); 
  assert (str=="health");
  return cur,max;
end
function nano.getHunger()
  local str, cur, sat = query("getHunger"); 
  assert (str=="hunger");
  return cur,sat;
end
function nano.getAge()
  local str, age = query("getAge"); 
  assert (str=="age")
  return age;
end
function nano.getName() 
  local str, name = query("getName"); 
  assert (str=="name");
  return name;
end
function nano.getExperience() 
  local str,exp = query("getExperience");
  assert (str=="experience");
  return exp;  
end
function nano.getTotalInputCount() 
  local str,count = query("getTotalInputCount");
  assert (str=="totalInputCount");
  return count;
end
function nano.getSafeActiveInputs() 
  local str,count = query("getSafeActiveInputs");
  assert (str=="safeActiveInputs");
  return count;
end
function nano.getMaxActiveInputs()
  local str,count = query("getMaxInputs");
  assert (str=="maxActiveInputs");
  return count;
end
function nano.getInput(num) 
  if type(num)~="number" then error("getInput requires a number",1) end
  local str, index, value = query("getInput",num);
  assert (str=="input" and index == num);
  return value;
end
function nano.setInput(num,value)
  if type(num)~="number" then error("setInput (**NUMBER**,boolean)",1) end
  if type(value)~="boolean" then error("setInput (number,**BOOLEAN**)",1) end
  local str,index,value = query("setInput",num,value);
  assert (str=="input" and index == num);
  return value;
end
function nano.getActiveEffects()
  local str,effects = query("getActiveEffects"); 
  assert (str == "effects");
  if effects == "{}" then return end;
  -- making the string into a table requires handling the missing " correctly.
  return effects;
end

-- intermediate part
-- maybe todo: mundane functions should nil the cache entries, call the functions, wait for it to be populated.

nano.cache = {};
local function responsehandler(msgtype, laddr, raddr, receivedport, dist, nanomachines, infotype, value1, value2)
  -- check if it's meant for us
  if receivedport ~= port or nanomachines ~= "nanomachines" then return true end;
  -- todo: more checks
  if infotype=="input" then 
    nano.cache["input"..value1] = value2;
  else
    nano.cache[infotype] = value1;
    if value2 then nano.cache[infotype..'2'] = value2; end
  end
  return true;
end
event.listen("modem_message",responsehandler);

function nano.off()
  local high = nano.cache.totalInputCount or nano.getTotalInputCount();
  for i = 1,high do
    nano.setInput(i,false); -- todo: consider direct, write-only path.
  end
end

-- Interesting part

nano.effectmap = {};

function nano.findEffects()
  nano.effectmap = {};
  for i=1,nano.getTotalInputCount() do
    nano.setInput(i,true);
    nano.effectmap[i]=nano.getActiveEffects(); --todo: trim {}s
    nano.setInput(i,false);
  end
end

function nano.showEffects()
  local high = nano.cache.totalInputCount or nano.getTotalInputCount();
  for i = 1,high do
    local v = nano.effectmap[i];
    if (v) then 
      print(i,v)
    end
  end
end


return nano;
