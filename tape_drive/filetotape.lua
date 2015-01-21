fs = require "filesystem"
component = require "component"

dbg = true;

param = {...};
tape = component.tape_drive;

filename = assert(param[1],"No file name given!");
if dbg then print(filename) end

file = assert(fs.open(filename,"r"))
if dbg then print(file) end

name = fs.name(filename);
name = string.gsub(name,"%.DFPWM","");

-- Side effects start here.

tape.setLabel(name);
x = tape.seek(-math.huge);

buf,err = file:read(4096);
while buf do
  tape.write(buf);
  buf = file:read(65535);
  io.write ".";
end
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