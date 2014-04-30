rs = require ("component").redstone
for k,v in pairs(require("sides")) do
  rs.setOutput(v,0)
end

