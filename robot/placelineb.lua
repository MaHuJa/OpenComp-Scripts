robot = require "robot"

length = tonumber(...)
if not length then error "Length needed" end

for _ = 1,length do
  robot.back()
  robot.place()
  io.write '.'
end
