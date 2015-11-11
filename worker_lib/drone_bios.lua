port = 83
function com(s)
  local c = component
  local r = c.list(s)()
  return c.proxy(r)
end
-- For debug
function dtk(t) 
  local ret = {}; 
  for k,_ in pairs(t) do 
    table.insert(ret,k) 
  end; 
  return table.concat(ret,' '); 
end
function dt(t) 
  local ret = {}; 
  for k,v in pairs(t) do 
    table.insert(ret,k) 
    table.insert(ret,v) 
  end; 
  return table.concat(ret,' '); 
end
function dti(t)
  return table.concat(t,' ');
end
mdm=com"modem"
mdm.open(port)
mdm.bc=mdm.broadcast
drn=com"drone"
pull = computer.pullSignal

local function wait()
  local evt,msg
  drn.setLightColor(0xff0000)
  drn.setStatusText('Available')
  repeat
    mdm.bc(port,"avail"); -- todo: type (drone), name, component list
    evt,_,raddr,_,_,msg = pull(5)
  until evt=='modem_message' and msg == 'acquire';
  mdm.send(raddr,port,'yours')
  -- todo: bc 'taken' ?
  drn.setStatusText(raddr)
  return assign()
end
local function assign()
  drn.setLightColor(0xffff00)
  repeat
    local evt,msg,param,from
    evt, _, from, _, msg, param = pull(300)
  until  evt=='modem_message' and from == raddr;
  if msg == 'release' then return wait() end
  if msg == 'do' then return work(param) end
  return assign()
end
local function work(param)
  drn.setLightColor(0x0000ff)
  local fn,err = load(param)
  if not fn then mdm.send(raddr,port,'compile_error',err) return assign() end
  local t = {pcall(fn)};
  for local k,v in ipairs(t) do
    if (type(v)=='table') then 
      t[k]=to_string(v) -- todo serialize
    end
  end
  if t[1]==false then 
    t[1]='error'
  else
    t[1]='done'
  end
  mdm.send(raddr,port,table.unpack(t))
  -- todo "error"; remove 
  return assign()
end
