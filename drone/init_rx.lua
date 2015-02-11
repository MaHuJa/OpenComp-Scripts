--[[
  init_rx
  Requires a drone with a wireless modem
  Waits for code to be transmitted
  
]]

function component.primary(name)
  return assert(component.proxy(component.list(name)()),"No component of type " .. name);
end

local port = math.random(100,3000);
local modem = component.primary("modem");
local drone = component.primary("drone");
local computer = component.primary("computer");
-- Get all data

remoteaddr = nil;

function getdata ()
  drone.setStatusText("Waiting " .. port);
  modem.open(port);
  
  code = {};
  
  local t = { computer.pullEvent("modem_message", nil, nil, port); };
  bindaddr = t[3];
  --assert (t[4]==port, "Message on closed port")
  while t[4] ~= 'finish' do
    table.insert(code,t[4]);
    t = { computer.pullEvent("modem_message", nil, bindaddr, port); };
  end
  return table.concat(code);
end

-- Compile and run
-- Not catching errors: We want them to pass through to the analyzer.
load(getdata())();


