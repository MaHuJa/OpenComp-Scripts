local args = {...}
-- Already done by caller
--component = require "component"
--event = require "event"
sides = require "sides"
log = log or function() end

-- fill/unfill uncommon code

function isReady(tank)
	if not tank then 
		log "No tank found"
		return true 
	end
	tank = tank.getTankInfo()[1]
	if tank.amount == 0 then 
		log ("Tank empty")
		return true 
	end
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
	rs.setOutput(removeside,15)
	coroutine.yield()
	rs.setOutput(removeside,0)
	rs.setOutput(placeside,15)
	coroutine.yield()
	rs.setOutput(placeside,0)
	is_replacing = false
end
	
local function replace()
	is_replacing = true
	f = coroutine.wrap (replace_worker)
	f()
	event.timer(0.8,f,2)
end

local function tick()
	if if_replacing then return end
	if isReady(component.proxy(tankaddr)) then
		replace()
	end
end

event.timer(0.5, tick, math.huge)

