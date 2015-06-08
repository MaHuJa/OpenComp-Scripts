component = require "component";
exp = component.experience;

print (exp.level())

param = ...;
if param == 'eat' then
  local rob = component.robot;
  for slot = rob.inventorySize(),1,-1 do
    if rob.count(slot)>0 then
      rob.select(slot)
      exp.consume()
    end
  end
  print(exp.level())
end

