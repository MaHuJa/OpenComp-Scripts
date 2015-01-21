fs = require "filesystem"
component = require "component"

tape = component.tape_drive;

-- Side effects start here.

tape.setLabel("Blank tape";);
x = tape.seek(-math.huge);
while tape.write(0) do io.write ".";

io.write "\n";

-- Leadout

if dbg then
  offs = tape.seek(-math.huge);
  print (offs);
  tape.seek(offs);
end

while not tape.isEnd() do
  tape.write(0);
end

tape.seek (-math.huge);
