local component = require("component")
local event = require("event")
local modem = component.modem
modem.open(1)
modem.broadcast(1, "drone=component.proxy(component.list('drone')())")
while true do
  local cmd=io.read()
  if not cmd then return end
  modem.broadcast(1, cmd)
  print(select(6, event.pull(5, "modem_message")))
end
