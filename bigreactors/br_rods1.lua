component = require "component";

reactor = component.br_reactor;

while true do
  os.sleep(1);
  local energylevel = reactor.getEnergyStored() / 10000000;
  --energylevel = energylevel * 10;
  energylevel = math.min(energylevel,1);
  reactor.setAllControlRodLevels(energylevel*100);
  print (1-energylevel);
end