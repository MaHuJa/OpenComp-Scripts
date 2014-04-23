local args = {...}
-- Already done by caller
--component = require "component"
--event = require "event"
sides = require "sides"
--serialize = require "serialize"
log = logmessage or function() end
logdebug = log --function() end

-- fill/unfill uncommon code

local function isReady(tank)
  print ("isReady")
  if not tank then 
    log "No tank found"
    return true 
  end
  tank = tank.getTankInfo()[1]
--  print (tank.name, tank.amount, tank.capacity)
  if tank.amount == tank.capacity then 
    print ("Tank full of " .. tank.name)
    return true 
  end
print (tank.amount, tank.name)
  return false
end

-- fill/unfill common code

local tankaddr = assert(args[1])
local rs = assert(args[2])
local removeside = assert(args[3])
local placeside = assert(args[4])

local is_replacing = false

rs = assert(component.proxy(rs))

local function replace_worker()
  logdebug "Actually Replacing"
  rs.setOutput(removeside,15)
  coroutine.yield()
  logdebug "Replacing - switch"
  rs.setOutput(removeside,0)
  rs.setOutput(placeside,15)
  coroutine.yield()
  logdebug "Replacing - end"
  rs.setOutput(placeside,0)
  is_replacing = false
end

local function replace()
  print "Starting replacing"
  is_replacing = true
  f = coroutine.wrap (replace_worker)
  f()
  event.timer(0.8,f,2)
end

local function tick()
  if is_replacing then return end
  local b = isReady(component.proxy(tankaddr)) 
  print (b)
  if b then
    replace()
  end
end

event.timer(0.5, tick, math.huge)