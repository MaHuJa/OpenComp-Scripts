local modem = component.modem;
local default_timeout = 5;
local default_port = 83;

droneaddr = {};
function dronedef(raddr)
  local ret = {};
  ret.status = 'avail';
  ret.raddr = raddr;
  ret.port = default_port;
  function ret.acquire(timeout)
    --todo
  end
  function ret.getComponentList(drone)
    modem.send(drone.raddr,drone.port,[[
      local t={};
      for component in component.list() do 
        t[#t+1] = component;
      end;
      return table.unpack(t);
    ]]);
  end
  return ret;
end
function incoming_message(evt, laddr, raddr, port, msg, ...)
  -- avail
  if msg == 'avail' then
    droneaddr[raddr]=droneaddr[raddr] or dronedef(raddr);
  end
  -- yours
  if msg == 'yours' then
    droneaddr[raddr].status='yours';
  end
  -- compile_error, aka you fucked up
  -- error, something threw an error()
  -- done, results follow
end
