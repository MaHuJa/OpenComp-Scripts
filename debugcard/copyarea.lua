component = require "component";
deb = component.debug;
w = debug.getWorld();

function vecadd (lhs,rhs)
  ret = {};
  for i = 1,#lhs,1 do
    ret[i] = lhs[i] + rhs[i];
  end
  return ret;
end
function vecdec (rhs)
  for k,v ipairs(rhs) do
    rhs[k] = v-1;
  end
  return rhs;
end

function copyarea(origin, size, destination)
  local unp = table.unpack;
  for x = 1,size[1] do
    for y = 1,size[2] do
      for z = 1,size[3] do
        local src = vecdec(vecadd(origin,{x,y,z}));
        local block = w.getBlockId (unp(src));
        local meta = w.getMetadata (unp(src));
        local dst = vecdec(vecadd(destination,{x,y,z}));
        w.setBlock(unp(dst),block,meta);
      end
    end
  end
end

