component = require ("component")
fs = require("filesystem")
sides = require ("sides")
process = require ("process")

local reactor = component.reactor_chamber
local rs = component.redstone
local rsside = sides.top

function turnOn(b)
  local str = 15
  if not b then str = 0 end
  rs.setOutput (rsside,str)
end
turnOn(false)

print ("Loading modules")
modules = {}
local moddir = fs.path(process.running())
moddir = fs.concat(moddir,"reactorm")
for file in fs.list(moddir) do
  print (file)
  local filename = fs.concat(moddir,file)
  assert (fs.exists(filename))
  modules[#modules+1] = assert(loadfile(filename))
end
if #modules == 0 then
  print ("WARNING! No control modules loaded!")
end

print ("Starting cycle")
terminate = false
local function loop()
  repeat
    local positive, total = 0,0
    local _,v
    for _,v in ipairs(modules) do
      res = v(reactor)
      total = total + 1
      if res then 
        positive = positive + 1 
      end
    end
    if positive==total then
      turnOn(true)
    else
      turnOn(false)
    end
    os.sleep (0.9)
  until terminate;
end
print(pcall(loop))
print ("Terminating, stopping reactor")
turnOn(false)

