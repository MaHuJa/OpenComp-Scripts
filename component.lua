component = require "component";
args = {...};
assert (args[1], "Specify component name");

c = component.getPrimary(args[1])

if not args[2] then 
  for k,v in pairs(c) do
    print(k,v);
  end
else
  print(component.doc(component[args[1]].address, args[2]));
end
  
