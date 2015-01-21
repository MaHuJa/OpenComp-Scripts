component = require "component";
turbine = component.br_turbine;
reactor = component.br_reactor;

rpm_min = 1800
rpm_max = 1850
rpm_emerg = 1950

state = function()
  print "State did not initialize"
  os.exit()
end

newstate = true;
function setstate(newfun)
  state = newfun;
  newstate = true;
end

-- Tune reactor: assume done

--[[ State1: Low RPM
  The turbine is not spinning fast enough. 
]]
function lowrpm ()
  if newstate then 
    newstate = false;
    print "Increasing RPM"
    reactor.setActive(true)
    turbine.setInductorEngaged(false)
    turbine.setActive(true)
  end
  -- TODO: Control rods to make sure we have enough steam. Work by turbine's input/setting
  if turbine.getRotorSpeed() > rpm_max then setstate(generate) end
end

if turbine.getRotorSpeed() < rpm_min then setstate(lowrpm) end

--[[ State2: Generation
  Generate power
]]
function generate()
  if newstate then
    newstate = false;
    print "Generating power"
    reactor.setActive(true)
    turbine.setInductorEngaged(true)
    turbine.setActive(true)
  end
  if turbine.getRotorSpeed() < rpm_min then setstate(lowrpm) end
  if turbine.getEnergyStored() > 800000 then setstate(idle) end
  if turbine.getRotorSpeed() > rpm_emerg then setstate(emergency) end
end

if turbine.getEnergyStored() < 800000 then setstate(generate) end

--[[ State3: Idle
  Any energy production will be wasted, so save some fuel
]]
function idle()
  if newstate then
    newstate = false;
    print "Idling"
    reactor.setActive(false)
    turbine.setInductorEngaged(false)
    turbine.setActive(true)
  end
  if turbine.getEnergyStored() < 5000 then setstate(generate) end
  if turbine.getRotorSpeed() < rpm_min then setstate(lowrpm) end
  if turbine.getRotorSpeed() > rpm_emerg then setstate(emergency) end
end

if turbine.getEnergyStored() >= 800000 then setstate(idle) end

--[[ State4: Emergency
  The rotor has reached a dangerous speed
]]
function emergency()
  if newstate then
    newstate = false;
    print "EMERGENCY BRAKES"
    reactor.setActive(false)
    turbine.setInductorEngaged(true)
    turbine.setActive(false)
  end
  if turbine.getRotorSpeed() < rpm_max then setstate(generate) end
end

if turbine.getRotorSpeed() > rpm_emerg then setstate(emergency) end

while true do
  os.sleep(1);
  state();
end
