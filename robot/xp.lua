robot = require "robot"

while robot.level()<30 do
  robot.swing()
  robot.place()
  print robot.level()
end