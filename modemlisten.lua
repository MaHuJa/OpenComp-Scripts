-- receiver
component = require "component"
event = require "event"
m = component.modem
m.open(1)
while true do 
  print(event.pull())
end