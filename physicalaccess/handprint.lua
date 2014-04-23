component = require ("component")
event = require ("event")

local rs = component.redstone
local side = require ("sides").bottom
local default = false
local duration = 3

local gpu = component.gpu
--local monitor = component.monitor

local has_access = {...}

--local monitor = address_here
local function rs_str(b)
  if b then return 15 else return 0 end
end
local function stop()
  rs.setOutput(side,rs_str(default))
end
local function start()
  rs.setOutput(side,rs_str(not default))
  event.timer(duration,stop,1)
end
local function in_array(needle,haystack)
  local k,v
  for k,v in pairs(haystack) do
    if needle==v then return true end
  end
  return false
end
local function clearstatus()
  local x,y = gpu.getResolution()
  gpu.fill(1,y,x,1,' ')
end
local function printstatus(text)
  local _,y = gpu.getResolution()
  gpu.set(1,y,text)
  event.timer(duration,clearstatus,1)
end

local function check(message,address,x,y,button,user)
  if monitor and address ~= monitor.address then return end
  if not user then 
    printstatus ("Handprint read failed. Equipment malfunction?")  -- meaning opencomputers config
    return
  end
  if in_array(user,has_access) then
    printstatus("Access granted")
    start()
  else
    printstatus("Access denied")
  end
  return true
end

event.listen("touch",check)

