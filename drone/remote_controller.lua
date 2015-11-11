local component = require("component")
local event = require("event")
local modem = component.modem
modem.open(5)
while true do
  local cmd=io.read()
  if not cmd then return end
  modem.broadcast(5, cmd)
  print(select(6, event.pull(5, "modem_message")))
end
