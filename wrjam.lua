component = require "component"

wr = component.savedmultipart

function setFreq(freq)
  wr.setFreq(freq)
end

function linear(min,max)
  min = min or 1
  max = max or 5000
  local i
  for i = min,max do
    coroutine.yield(i)
  end
end

math.randomseed(os.time())

function random(count)
  count = count or 500000
  local _
  for i = 1,count do
    coroutine.yield(math.random(1,5000))
  end
end

--algo = coroutine.wrap(linear)
algo = coroutine.wrap(random)

local freq
repeat
  freq = algo()
  if freq then setFreq(freq) end
  os.sleep(0.1)
until not freq

setFreq(0)