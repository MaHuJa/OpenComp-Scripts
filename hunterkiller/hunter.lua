local rangegate = 1.5;
local port = 0x64;
local killerlabel = 'killer';
local killeraddr = '';

--
local killer_ready = true;

-- Tracking

rangegate = rangegate*rangegate;
local current = {}; --{ x,y,z, id='', lastseen=0 };
local killer = {};	--{x,y,z}

function on_motion (_,x,y,z,id)
	if not current.id then
		current = {x,y,z,'id'=id};
	end
	if current.id == id then
		local dx, dy, dz = current[1]-x, current[2]-y, current[3]-z;
		local distance = dx*dx+dy*dy+dz*dz
		if distance < rangegate then 
			current[1], current[2], current[3] = x,y,z;
			current.lastseen = computer.uptime();
		end
	end
	if id == killerlabel then
		killer[1],killer[2],killer[3] = x,y,z
	end
	if killer_ready then send_target() end
	return true;
end
--event.listen("motion",on_motion);

-- Messaging
modem = component.modem;
modem.open(port);

function send_target()
	killer_ready = false
	modem.send(killeraddr, port, 'target', current[1]-killer[1], current[2]-killer[2]+1, current[3]-killer[3])
end
function send_reset()
	modem.send(killeraddr, port, 'reset')
end
function send_range(r)
	modem.setStrength(r+2);
	modem.send(killeraddr, port, 'range', r+2);
end

function on_modem(_,laddr, raddr, recport, dist, message)
	if raddr ~= killeraddr or port ~= recport then return end
	if message == 'nothing' then 
		send_target()
	elseif message == 'reset' then
		killer_ready = true;
	end
	
end


