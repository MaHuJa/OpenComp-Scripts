robot = require ("robot")

function place(fn)
  if fn() then return true end
  for i = 1,16 do
    if robot.count(i) > 0 then
      robot.select(i);
      if fn() then return true
      else robot.drop(64)
      end
    end
  end
  return false, "Unknown error in place()";
end

while true do
  assert(place(robot.place))
  assert(robot.swing())
end
