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
-- end debug utilities
function com(s)
  local c = component
  local r = c.list(s)()
  return c.proxy(r)
end
modem = com "modem";
modem.open(5);
drone = com "drone";
modem.broadcast(5,"HERE I AM!")

while true do
  repeat
    evt, laddr, raddr, port, dist, msg = computer.pullSignal()
  until evt == "modem_message"
  local raddr = raddr
  local fn, err = load(msg);
  if not fn then modem.send(raddr,5,err)
  else
    local ret = {pcall(fn)}
    modem.send(raddr,5, table.unpack(ret))
  end
end
