local modem = component.modem;
local default_timeout = 5;
local default_port = 83;

-- class worker
local worker_meta = {
	__index = worker_meta;
	function touch(this) this.last_update = os.clock(); end,
	
}
function new_worker(raddr)
	ret.last_update = os.clock()
  local ret = {
	  function acquire(this)
			modem.send(this.raddr, this.port, 'acquire');
			repeat 
				event.pull('modem_message',nil,raddr);
			until this.status ~= 'avail';
			return this.status == 'yours';
		end,
		function command(this, cmd)
			-- check that it compiles
			assert(type(this)=='table');
			assert(type(cmd)=='string');
			assert(load(cmd));
			modem.send (this.raddr, this.port, 'do', cmd);
			repeat event.pull('modem_message') until this.returns;
			local ret = this.returns;
			this.returns = nil;
			return table.unpack(ret)
		end,
		function release(this)
			modem.send(raddr,this.port, 'release');
		end,
		function has_all(this,component_type, ...)
			if not component_type then return true end;
			return this.components [component_type] and this:has_all(...)
		end,
	};
  ret.status = 'avail';
  ret.raddr = raddr;
  ret.port = default_port;
	ret.returns = nil;
	ret.components = {};
	setmetatable (ret,worker_meta);
end

workerlist = {};
function find_worker(...)
	for k,v in pairs(workerlist) do
		if v.status == 'avail' and v.has_all(...) then
			return v;
		end
	end
end

function incoming_message(evt, laddr, raddr, port, msg, ...)
  local worker = workerlist[raddr];
  if msg == 'avail' then
		if not worker then
			worker = new_worker(raddr);
			workerlist[raddr] = worker;
		end
		for v in ipairs{...} do
			worker.components[v]=true;
		end
  elseif msg == 'yours' then
		worker.status = 'yours'
  elseif msg == 'taken' then
		if worker.status ~= 'yours' then
			worker.status = 'taken'
		end
	elseif msg == 'compile_error' then
		print(...) os.sleep(5)
	elseif msg == 'error'
		worker.returns = {nil,...}
	elseif msg == 'done'
		worker.returns = {...};
	end;
end
