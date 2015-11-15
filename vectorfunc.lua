function vecadd(a,b)
  res = {};
  for i = 1,#a do
    res[i] = a[i]+b[i];
  end
  return res;
end
function vecsub(a,b)
  res = {};
  for i = 1,#a do
    res[i] = a[i]-b[i];
  end
  return res;
end
function vecmul(a,b)
  assert (type(b)=='number',"vecmul rhs must be a number")
  res = {};
  for i = 1,#a do
    res[i] = a[i]*b;
  end
  return res;
end
function vecdist(a)
  local l = 0;
  for _,v in ipairs(a) do l = l + v*v end;
  return math.sqrt(l);
end

function extrapolate (a,b,distance)
  local diff = vecsub(a,b)
  local dist = vecdist(diff)
  local newdiff = vecmul(diff,distance/dist)
  return vecadd(a,newdiff);
end
