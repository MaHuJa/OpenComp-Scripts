

param = {...}
portno = assert (tonumber(param[1]), "Could not read port number";
filename = "dronerc.lua" or param[2];

file = assert(io.open(filename,"r"), "Could not open " .. filename);
segmentmax = 4000;

local text = file:read(segmentmax);
while text do
	modem.broadcast(portno,text);
	text = file:read(segmentmax);
	io.write ('.');
	sleep (0.04);
end
modem.broadcast(portno,"finish");
