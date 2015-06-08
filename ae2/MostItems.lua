component = require "component";
mec = component.me_controller
all = mec.getItemsInNetwork()
table.sort(all,function(a,b) return a.size>b.size end)

count = tonumber(...) or 15

for i = 1,count do
  print (all[i].size, all[i].label)
end
