component = require ("component")

reactor = component.reactor_chamber
rs = component.redstone

rsside = require("sides").top

function check()
  heat = reactor.getHeat() / reactor.getMaxHeat()
  return heat < 0.84
end

while check() do
  rs.setOutput (rsside,15)
  print (reactor.getHeat(), reactor.getMaxHeat())
  sleep(0.9)
end
rs.setOutput(rsside,0)

print "Ended reactor pre-heating at "
print (reactor.getHeat())
print "out of max"
print (reactor.getMaxHeat())

