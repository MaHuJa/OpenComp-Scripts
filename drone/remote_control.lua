function com(s)
  local c = component
  local r = c.list(s)()
  return c.proxy(r)
end

modem = com "modem";
modem.open(5);

modem.broadcast(5,"HERE I AM!")

while true do
  repeat
    evt, laddr, raddr, port, dist, msg = computer.pullSignal()
  until evt == "modem_message"
  local raddr = raddr
  local fn, err = load(msg);
  if not fn then modem.send(raddr,5,err)
  else
    modem.send(raddr,5,
      pcall(fn)
    )
  end
end
