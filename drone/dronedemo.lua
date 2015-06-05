--dronedemo
c = component
d = c.list "drone"
d = c.proxy(d())
comp = c.list "computer"
comp = c.proxy(comp())

function wait()
  repeat until d.getOffset() > 1;
  comp.beep(900,0.3);
end
function p(msg)
  return d.setStatusText(msg)
end


p "Rising" d.move(0,2,0) wait()
p "wp1" d.move(-5,0,0) wait()
p "wp2" d.move(5,0,5) wait()
p "wp3" d.move(5,0,-5) wait()
p "wp4" d.move(-5,0,-5) wait()
p "wp5" d.move(0,0,5) wait()


